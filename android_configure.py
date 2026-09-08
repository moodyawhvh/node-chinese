# =============================================================================
# android_configure.py —— Android 交叉编译配置辅助脚本(中文注释版)
# 作用:配置 NDK 工具链环境变量,并调用 ./configure 生成面向 Android 的构建配置。
# 用法:./android-configure [patch] <NDK 路径> <Android SDK 版本> <目标架构>
# =============================================================================

import platform
import sys
import os

# TODO: In next version, it will be a JSON file listing all the patches, and then it will iterate through to apply them.
# 应用 Android 平台所需的补丁(目前仅处理 V8 的 trap-handler.h,见 nodejs/node#36287)。
def patch_android():
    print("- Patches List -")
    print("[1] [deps/v8/src/trap-handler/trap-handler.h] related to https://github.com/nodejs/node/issues/36287")
    # 仅 Linux 上存在 patch 命令时才执行打补丁操作
    if platform.system() == "Linux":
        os.system('patch -f ./deps/v8/src/trap-handler/trap-handler.h < ./android-patches/trap-handler.h.patch')
    print("\033[92mInfo: \033[0m" + "Tried to patch.")

# 平台检查:本脚本只支持 Linux 与 macOS(Darwin)
if platform.system() != "Linux" and platform.system() != "Darwin":
    print("android-configure is currently only supported on Linux and Darwin.")
    sys.exit(1)

# 子命令 "patch":仅应用补丁后退出
if len(sys.argv) == 2 and sys.argv[1] == "patch":
    patch_android()
    sys.exit(0)

# 参数校验:必须恰好提供 NDK 路径、SDK 版本、目标架构三个参数
if len(sys.argv) != 4:
    print("Usage: ./android-configure [patch] <path to the Android NDK> <Android SDK version> <target architecture>")
    sys.exit(1)

# 校验 NDK 路径存在且非空目录
if not os.path.exists(sys.argv[1]) or not os.listdir(sys.argv[1]):
    print("\033[91mError: \033[0m" + "Invalid path to the Android NDK")
    sys.exit(1)

# 校验 SDK 版本:最低 24(Android 7.0),低于此版本不予支持
if int(sys.argv[2]) < 24:
    print("\033[91mError: \033[0m" + "Android SDK version must be at least 24 (Android 7.0)")
    sys.exit(1)

# 解析命令行参数
android_ndk_path = sys.argv[1]
android_sdk_version = sys.argv[2]
arch = sys.argv[3]

# 将用户传入的架构名映射为 Node.js 的 DEST_CPU 与 NDK 三元组前缀:
#   arm     -> DEST_CPU=arm   (armv7a-linux-androideabi)
#   aarch64/arm64 -> DEST_CPU=arm64 (aarch64-linux-android)
#   x86     -> DEST_CPU=ia32  (i686-linux-android)
#   x86_64  -> DEST_CPU=x64   (x86_64-linux-android)
if arch == "arm":
    DEST_CPU = "arm"
    TOOLCHAIN_PREFIX = "armv7a-linux-androideabi"
elif arch in ("aarch64", "arm64"):
    DEST_CPU = "arm64"
    TOOLCHAIN_PREFIX = "aarch64-linux-android"
    arch = "arm64"
elif arch == "x86":
    DEST_CPU = "ia32"
    TOOLCHAIN_PREFIX = "i686-linux-android"
elif arch == "x86_64":
    DEST_CPU = "x64"
    TOOLCHAIN_PREFIX = "x86_64-linux-android"
    arch = "x64"
else:
    print("\033[91mError: \033[0m" + "Invalid target architecture, must be one of: arm, arm64, aarch64, x86, x86_64")
    sys.exit(1)

print("\033[92mInfo: \033[0m" + "Configuring for " + DEST_CPU + "...")

# 根据宿主操作系统定位 NDK 内预构建的 LLVM 工具链目录
if platform.system() == "Darwin":
    host_os = "darwin"
    toolchain_path = android_ndk_path + "/toolchains/llvm/prebuilt/darwin-x86_64"

elif platform.system() == "Linux":
    host_os = "linux"
    toolchain_path = android_ndk_path + "/toolchains/llvm/prebuilt/linux-x86_64"

# 将 NDK 工具链加入 PATH,并指定 clang/clang++ 作为交叉编译器
# (NDK 的编译器命名形如 <三元组><SDK版本>-clang,自动绑定目标平台与 API 级别)
os.environ['PATH'] += os.pathsep + toolchain_path + "/bin"
os.environ['CC'] = toolchain_path + "/bin/" + TOOLCHAIN_PREFIX + android_sdk_version + "-" +  "clang"
os.environ['CXX'] = toolchain_path + "/bin/" + TOOLCHAIN_PREFIX + android_sdk_version + "-" + "clang++"

# 传给 GYP 的构建定义:目标架构、宿主/目标操作系统、NDK 路径
GYP_DEFINES = "target_arch=" + arch
GYP_DEFINES += " v8_target_arch=" + arch
GYP_DEFINES += " android_target_arch=" + arch
GYP_DEFINES += " host_os=" + host_os + " OS=android"
GYP_DEFINES += " android_ndk_path=" + android_ndk_path
os.environ['GYP_DEFINES'] = GYP_DEFINES

# 最后调用 Node.js 的 configure:
#   --dest-cpu/--dest-os 指定目标平台;
#   --openssl-no-asm 关闭 OpenSSL 汇编(交叉编译下不提供 Android 汇编);
#   --cross-compiling 声明交叉编译模式。
if os.path.exists("./configure"):
    os.system("./configure --dest-cpu=" + DEST_CPU + " --dest-os=android --openssl-no-asm --cross-compiling")
