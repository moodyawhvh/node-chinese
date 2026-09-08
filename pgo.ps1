# PGO (Profile-Guided Optimization) training script for Node.js (Clang / LLVM)
# —— Node.js 的 PGO(基于配置文件的优化)训练脚本(Clang / LLVM 工具链)
#
# Runs PGO training workloads against an instrumented Node.js binary
# (Release\node.exe) and merges the resulting .profraw files into
# node.profdata for use with -fprofile-use.
# 对带插桩(instrumented)的 Node.js 二进制(Release\node.exe)运行 PGO 训练负载,
# 并把生成的 .profraw 文件合并为 node.profdata,供 -fprofile-use 使用。
#
# Usage (from a VS Developer Command Prompt):
#   .\pgo.ps1                     # Run workloads (15s each) and merge
#   .\pgo.ps1 -Duration 30        # Run workloads (30s each) and merge
# 用法(在 VS 开发者命令提示符中):
#   .\pgo.ps1                     # 运行训练负载(每个 15 秒)并合并
#   .\pgo.ps1 -Duration 30        # 运行训练负载(每个 30 秒)并合并
#
# Prerequisites:
#   - Release\node.exe must be an instrumented build (built with pgo-generate)
#   - llvm-profdata must be available (shipped with VS LLVM toolset)
# 前提条件:
#   - Release\node.exe 必须是插桩构建(用 vcbuild.bat pgo-generate 生成)
#   - 需要 llvm-profdata(随 VS 的 LLVM 工具集提供)
#
# Output:
#   - node.profdata in the repo root (ready for vcbuild.bat pgo-use)
# 输出:
#   - 仓库根目录下的 node.profdata(可直接用于 vcbuild.bat pgo-use)

# 脚本参数:每个训练负载的运行时长(秒)
param(
    [int]$Duration = 15
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Locate llvm-profdata shipped with Visual Studio's LLVM toolset
# 定位 Visual Studio LLVM 工具集自带的 llvm-profdata
# ---------------------------------------------------------------------------

function Find-LlvmProfdata {
    # vcbuild.bat uses %VCINSTALLDIR%\Tools\Llvm\x64\bin for clang.exe - same spot for profdata
    # vcbuild.bat 使用 %VCINSTALLDIR%\Tools\Llvm\x64\bin 下的 clang.exe,profdata 也在同一位置
    $vcInstallDir = $env:VCINSTALLDIR

    if ($vcInstallDir) {
        $candidate = Join-Path $vcInstallDir "Tools\Llvm\x64\bin\llvm-profdata.exe"
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    # Fallback: try VS 2022 / 2026 default install locations
    # 兜底:尝试 VS 2022 / 2026 的默认安装位置
    $vsPaths = @(
        "${env:ProgramFiles}\Microsoft Visual Studio\2026\Enterprise\VC\Tools\Llvm\x64\bin",
        "${env:ProgramFiles}\Microsoft Visual Studio\2026\Community\VC\Tools\Llvm\x64\bin",
        "${env:ProgramFiles}\Microsoft Visual Studio\2022\Enterprise\VC\Tools\Llvm\x64\bin",
        "${env:ProgramFiles}\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\x64\bin"
    )
    foreach ($dir in $vsPaths) {
        $candidate = Join-Path $dir "llvm-profdata.exe"
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    # Last resort: PATH
    # 最后手段:从 PATH 中查找
    $fromPath = Get-Command llvm-profdata -ErrorAction SilentlyContinue
    if ($fromPath) {
        return $fromPath.Source
    }

    return $null
}

# ---------------------------------------------------------------------------
# Validate prerequisites
# 校验前提条件
# ---------------------------------------------------------------------------

# 必须已存在插桩版 node.exe(由 vcbuild.bat pgo-generate 构建)
$instrumentedNode = Join-Path $PSScriptRoot "Release\node.exe"
if (-not (Test-Path $instrumentedNode)) {
    Write-Error "Instrumented binary not found: $instrumentedNode`nBuild with: vcbuild.bat pgo-generate"
    exit 1
}

# 必须存在 PGO 训练负载脚本
$pgoRunAll = Join-Path $PSScriptRoot "tools\pgo\pgo-run-all.js"
if (-not (Test-Path $pgoRunAll)) {
    Write-Error "PGO training script not found: $pgoRunAll"
    exit 1
}

$llvmProfdata = Find-LlvmProfdata
if (-not $llvmProfdata) {
    Write-Error "llvm-profdata not found. Install the LLVM toolset via Visual Studio Installer."
    exit 1
}

# ---------------------------------------------------------------------------
# STEP 1 – Run workloads with the instrumented binary to collect profiles
# 第 1 步 —— 用插桩二进制运行训练负载,采集性能剖析数据
# ---------------------------------------------------------------------------

Write-Host "`n=== STEP 1: Collect PGO profiles ===" -ForegroundColor Cyan

# Directory that will receive .profraw files from the instrumented binary.
# %p (PID) and %m (module hash) keep concurrent/fork'd processes from colliding.
# 该目录用于接收插桩二进制产出的 .profraw 文件。
# 文件名中的 %p(进程 ID)与 %m(模块哈希)可避免并发/fork 出的进程相互覆盖。
$profileDir = Join-Path $PSScriptRoot "pgo-profiles"

# 清理旧的剖析数据目录并重建
if (Test-Path $profileDir) {
    Remove-Item -Recurse -Force $profileDir
}
New-Item -ItemType Directory -Path $profileDir | Out-Null

# 通过环境变量 LLVM_PROFILE_FILE 指定 .profraw 输出路径模板
$env:LLVM_PROFILE_FILE = Join-Path $profileDir "node-%p-%m.profraw"

Write-Host "Instrumented node : $instrumentedNode"
Write-Host "Profile output    : $($env:LLVM_PROFILE_FILE)"
Write-Host "Duration per script: ${Duration}s"
Write-Host ""

# 同步运行训练负载,并统计耗时;训练失败不立即中止,继续执行合并步骤
$sw = [System.Diagnostics.Stopwatch]::StartNew()
$proc = Start-Process `
    -FilePath $instrumentedNode `
    -ArgumentList "`"$pgoRunAll`" --verbose --duration=$Duration" `
    -Wait -PassThru -NoNewWindow
$sw.Stop()
Write-Host ("PGO training completed in {0}m {1}s (exit code: {2})" -f `
    $sw.Elapsed.Minutes, $sw.Elapsed.Seconds, $proc.ExitCode)
if ($proc.ExitCode -ne 0) {
    Write-Warning "PGO training exited with code $($proc.ExitCode) - continuing with merge"
}

# Remove the env var so subsequent builds are not affected
# 移除该环境变量,避免影响后续构建
Remove-Item Env:\LLVM_PROFILE_FILE -ErrorAction SilentlyContinue

# ---------------------------------------------------------------------------
# STEP 2 – Merge .profraw files -> node.profdata
# 第 2 步 —— 合并 .profraw 文件 -> node.profdata
# ---------------------------------------------------------------------------

Write-Host "`n=== STEP 2: Merge profile data ===" -ForegroundColor Cyan

Write-Host "Using llvm-profdata: $llvmProfdata"

# 收集全部 .profraw 文件;若一个都没有,说明插桩二进制未产出剖析数据
$profrawFiles = Get-ChildItem -Path $profileDir -Filter "*.profraw" -ErrorAction SilentlyContinue
if ($profrawFiles.Count -eq 0) {
    Write-Error "No .profraw files found in '$profileDir'. The instrumented binary may not have generated profile data."
    exit 1
}

$totalSize = ($profrawFiles | Measure-Object -Property Length -Sum).Sum
$totalSizeMB = [math]::Round($totalSize / 1MB, 1)
Write-Host "Found $($profrawFiles.Count) .profraw file(s), ${totalSizeMB} MB total"

# 执行 llvm-profdata merge,把所有 .profraw 合并成单个 node.profdata
$profdata = Join-Path $PSScriptRoot "node.profdata"
$mergeArgs = @("merge", "--output=$profdata") + ($profrawFiles | Select-Object -ExpandProperty FullName)

$mergeStopwatch = [System.Diagnostics.Stopwatch]::StartNew()
& $llvmProfdata @mergeArgs
$mergeExitCode = $LASTEXITCODE
$mergeStopwatch.Stop()

# 合并失败则报错退出
if ($mergeExitCode -ne 0) {
    Write-Error "llvm-profdata merge failed (exit code $mergeExitCode)"
    exit $mergeExitCode
}

$profdataSize = [math]::Round((Get-Item $profdata).Length / 1MB, 1)
Write-Host "Merge completed in $([math]::Round($mergeStopwatch.Elapsed.TotalSeconds, 1))s"

# Clean up .profraw files now that they've been merged
# 合并完成后清理中间 .profraw 文件,释放磁盘空间
Remove-Item -Recurse -Force $profileDir
Write-Host "Removed $($profrawFiles.Count) .profraw file(s) (${totalSizeMB} MB reclaimed)"
