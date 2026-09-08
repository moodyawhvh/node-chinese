> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。
>
> ⚠️ 说明:本文件篇幅超过 10000 字符,此处仅翻译核心章节(支持平台、构建前提、Unix/macOS 与 Windows 构建流程、运行测试、Intl 支持概览)。ASan 构建、Nix 集成、FIPS、Temporal、外部核心模块、发行版注意事项等其余章节请参阅[英文原版](https://github.com/nodejs/node/blob/HEAD/BUILDING.md)。

# 构建 Node.js

根据所需平台和特性的不同,构建流程可能有差异。构建出二进制后,下一步建议运行测试套件,确认二进制按预期工作。

如果你能复现某个测试失败,请先在 [Node.js issue 跟踪器](https://github.com/nodejs/node/issues)搜索,再决定是否提交新 issue。

## 支持平台

### 策略

支持分三个层级:

* **Tier 1**:代表 Node.js 用户的主体。Node.js 构建工作组维护完整的测试覆盖基础设施。Tier 1 平台上的测试失败会阻塞发布。
* **Tier 2**:代表较小规模的用户群体。同样维护完整测试覆盖,测试失败同样阻塞发布;基础设施问题可能延迟这些平台二进制的发布。
* **Experimental**:可能无法编译或测试套件无法通过。核心团队不为这些平台产出发布版,测试失败不阻塞发布。欢迎改进这些平台支持的贡献。

**生产应用请只在受支持平台(Tier 1 或 2)上运行 Node.js。**

厂商已停止支持的平台版本,Node.js 同样不支持,即不支持已到生命周期终点(EoL)的平台。

平台支持概览(完整表格见英文原版):

| 操作系统   | 架构             | 版本要求                          | 支持层级     | 备注                                  |
| ---------- | ---------------- | --------------------------------- | ------------ | ------------------------------------- |
| GNU/Linux  | x64              | kernel >= 4.18, glibc >= 2.28     | Tier 1       | 如 Ubuntu 20.04、Debian 10、RHEL 8    |
| GNU/Linux  | x64              | kernel >= 3.10, musl >= 1.1.19    | Experimental | 如 Alpine 3.8                         |
| GNU/Linux  | arm64            | kernel >= 4.18, glibc >= 2.28     | Tier 1       | 如 Ubuntu 20.04、Debian 10、RHEL 8    |
| GNU/Linux  | ppc64le >=power9 | kernel >= 4.18, glibc >= 2.28     | Tier 2       | 如 Ubuntu 20.04、RHEL 8               |
| GNU/Linux  | s390x >=z14      | kernel >= 4.18, glibc >= 2.28     | Tier 2       | 如 RHEL 8                             |
| GNU/Linux  | armv7 / x86 / loong64 / riscv64 | 见英文原版          | Experimental |                                       |
| Windows    | x64              | >= Windows 10/Server 2016         | Tier 1       | mintty 等终端需 winpty;不支持 WSL     |
| Windows    | arm64            | >= Windows 10                     | Tier 2       |                                       |
| macOS      | arm64            | >= 13.5                           | Tier 1       | 编译需 Xcode 16                       |
| macOS      | x64              | >= 13.5                           | Tier 2       | 2028 年初前                           |
| SmartOS    | x64              | >= 18                             | Tier 2       |                                       |
| AIX        | ppc64be >=power9 | >= 7.2 TL04                       | Tier 2       |                                       |
| FreeBSD    | x64              | >= 13.2                           | Experimental |                                       |
| OpenHarmony| arm64            | >= 5.0                            | Experimental |                                       |

### 受支持的工具链

| 操作系统 | 编译器版本                                                          |
| -------- | ------------------------------------------------------------------- |
| Linux    | GCC >= 13.2 或 Clang >= 19.1                                        |
| Windows  | 64 位主机上的 Visual Studio 2022 或 2026 + Windows 11 SDK           |
| macOS    | Xcode >= 16.4(Apple LLVM >= 19)                                    |

<https://nodejs.org/download/release/> 上的官方二进制在 RHEL 8(Linux,Clang 20.1)、Windows Server 2022(Visual Studio 2022)、macOS 15(Xcode 16,最低兼容 13.5)、AIX 7.2 TL04(Clang 20.1)等系统上产出。自 Node.js 25 起,官方 Linux 二进制链接 `libatomic`,运行环境需已安装 `libatomic`(或 `libatomic1`)运行时。

### 本文档的历史版本

支持的平台与工具链随 Node.js 每个主版本变化。本文档仅对当前版本有效。查阅其他版本文档,请下载对应源码包或检出相应 git 标签。

## 在受支持平台上构建 Node.js

### 前提条件

* [受支持的 Python 版本][Python versions](不含预发布版本),用于构建和测试。
* 若需[构建带 Temporal 支持的 Node.js](https://github.com/nodejs/node/blob/HEAD/BUILDING.md#building-nodejs-with-temporal-support),需要 Rust 工具链。
* 内存:4 个并行编译任务(如 `make -j4`)通常至少需要 8GB 内存。

### Unix 与 macOS

Unix 前提条件:

* `gcc`/`g++` >= 13.2 或 `clang`/`clang++` >= 19.1
* GNU Make 3.81 或更新
* [受支持的 Python 版本][Python versions](做测试覆盖率需含 pip)

可通过发行版包管理器安装,例如:

```bash
# Ubuntu / Debian
sudo apt-get install python3 g++-13 gcc-13 make python3-pip
# Fedora
sudo dnf install python3 gcc-c++ make python3-pip
# CentOS / RHEL
sudo yum install python3 gcc-c++ make python3-pip
```

macOS 前提条件:Xcode Command Line Tools >= 16.4(运行 `xcode-select --install` 安装,将同时装好 `clang`、`clang++` 和 `make`),以及受支持的 Python 版本。

构建 Node.js:

```bash
./configure
make -j4
```

> \[!IMPORTANT]
> 若编译报 `error: no matching conversion for functional-style cast from 'unsigned int' to 'TypeIndex'` 之类的错误,请确认 `g++`/`clang` 版本兼容 C++20。

`-j4` 让 `make` 同时跑 4 个编译任务以缩短构建时间。也可以用 [Ninja](https://ninja-build.org/) 加速,详见[用 Ninja 构建 Node.js](doc/contributing/building-node-with-ninja.md)。若构建目录路径包含空格,构建很可能失败。

安装到系统目录:

```bash
[sudo] make install
```

#### 运行测试

```bash
make test
```

可运行 `make test-only` 跳过构建检查只跑测试。完整说明见英文原版。

#### 构建文档

```bash
make doc
```

构建后的文档位于 `out/doc`。可用 `make docserve` 起本地服务器预览,或 `make docclean` 清理。

#### 加速频繁重建

* **ccache**:若需频繁重建(尤其多分支切换),安装 `ccache` 可大幅缩短构建时间,例如 `sudo apt install ccache` 后设置 `export CC="ccache gcc"`、`export CXX="ccache g++"`(写入 `.profile`)。
* **从磁盘加载 JS 文件而非内嵌**:只改 `lib` 中的 JS 层时,可执行 `./configure --node-builtin-modules-path "$(pwd)"`,产出的二进制不含 JS 文件、从指定目录加载,便于配合 VS Code 调试断点。

#### Unix/macOS 构建排障

* 陈旧的构建产物可能导致 `file not found` 等错误,用 `make distclean` 清理后需重新 `./configure`(非默认选项需重跑)再 `make -j4`。
* 出现 `g++ fatal error compilation terminated cc1plus` 通常是内存不足:增加内存/交换空间,或降低并行任务数(`-j<n>`)。

### Windows

前提条件(手动安装):

* 当前版本的 [Python][Python downloads](参照 [Using Python on Windows][])。
* 从 [Visual Studio Downloads](https://visualstudio.microsoft.com/downloads/) 下载安装 Visual Studio Community Edition 2026(或 Build Tools for Visual Studio 2026,磁盘占用最小;Professional/Enterprise 亦可)。安装时勾选"使用 C++ 的桌面开发"工作负载。
* 自 Node.js 24.0.0 起,Windows 编译要求 ClangCL,需额外勾选两个可选组件:
  * C++ Clang Compiler for Windows(Microsoft.VisualStudio.Component.VC.Llvm.Clang)
  * MSBuild support for LLVM (clang-cl) toolset(Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset)
* 也可用 Visual Studio 2022 Current 通道 17.14 版替代 2026,组件选择相同。
* Node.js 26 引入的 Temporal 支持所需 Rust 工具链:先装好 Visual Studio,再运行 [Install Rust](https://rust-lang.org/tools/install/) 下载的 `rustup-init.exe`,选默认"Proceed with standard installation"。
* 部分测试需要基本 Unix 工具:[Git for Windows](https://git-scm.com/download/win) 自带的 Git Bash 工具可加入全局 `PATH`。
* OpenSSL 汇编模块需要 [NetWide Assembler](https://www.nasm.us/);未装在默认位置时需手动加入 `PATH`(`--openssl-no-asm` 构建和 ARM64 Windows 目标不需要)。

也可用 [WinGet 配置文件](./.configurations)自动安装全部前提(Git for Windows、Python 3.14、Visual Studio 2022 + 工作负载与 Clang 组件、Rust 工具链、NASM),在 PowerShell 中配合 [winget configure](https://learn.microsoft.com/en-us/windows/package-manager/winget/configure#configure-subcommands) 使用。

构建 Node.js(在 `vcbuild.bat` 所在目录):

```powershell
# 构建调试版(不带符号):
.\vcbuild build-release
# 或按交互提示:
.\vcbuild
```

可用 `vcbuild.bat help` 查看全部选项。若遇到与 zlib.lib/zlib1.dll 相关的符号重定义链接错误,可能需要 `vcpkg integrate remove` 移除 vcpkg 集成。

### Android

参照英文原版 `Building Node.js on Android` 一节,使用 `android-configure` 脚本配置 NDK 交叉编译环境。

## `Intl`(ECMA-402)支持概览

Node.js 的 Intl 支持由 `configure` 的 `--with-intl` 参数决定,四种模式:

* **full-icu**(完整 ICU,支持全部语言环境;默认随构建下载 ICU 数据):

  ```bash
  # Unix / macOS(需已配置,下载需要网络,也可用 --download=all)
  ./configure --with-intl=full-icu --download=all
  ```

  ```powershell
  # Windows
  .\vcbuild build-release-icu
  ```

* **small-icu**(精简 ICU,仅英语,二进制更小):

  ```bash
  ./configure --with-intl=small-icu
  ```

* **none**(不含 Intl 支持):

  ```bash
  ./configure --with-intl=none
  ```

* **system-icu**(链接系统已装的 ICU,仅 Unix/macOS):

  ```bash
  ./configure --with-intl=system-icu
  ```

构建时也可用 `--with-icu-source` 指定特定 ICU 源码路径或 tarball。完整细节见英文原版。

## 下游发行者注意事项

下游 Node.js 发行方(发行版打包者等)的注意事项(如构建产物、文档、测试套件的处理建议)见英文原版对应章节。

[Python versions]: https://devguide.python.org/versions/#supported-versions
[Python downloads]: https://www.python.org/downloads/
[Using Python on Windows]: https://docs.python.org/3/using/windows.html
