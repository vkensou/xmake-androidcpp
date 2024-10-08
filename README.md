## Language
- [中文](#中文)
- [English](#english)

### 中文
基于xmake实现纯C/C++开发安卓应用

本仓库是个示例工程，其中文件夹androidcpp是必须的。AndroidManifest.xml也是必须的，目前没有实现自动生成。

使用方法：
1. 设置target的kind为shared
2. 添加rule，并设置相关参数

参考xmake.lua写法
```
includes("androidcpp")

target("xmake-androidcpp")
    add_rules("androidcpp", {android_sdk_version = "34", android_manifest = "AndroidManifest.xml", android_res = "res", android_assets = "assets", apk_output_path = ".", package_name = "com.xmake.androidcpp", activity_name = "android.app.NativeActivity"})
    set_kind("shared")
    add_files("src/*.c")
    add_syslinks("log", "android", "GLESv2", "EGL", "OpenSLES", "m")
```

xmake命令
```
xmake config -p android -a arm64-v8a
xmake build
xmake install -o build xmake-androidcpp
xmake run xmake-androidcpp
```

一个典型的命令执行结果如下
```
PS F:\yourcode\xmake-androidcpp> xmake config -p android -a arm64-v8a
PS F:\yourcode\xmake-androidcpp> xmake build
[100%]: build ok, spent 0.031s
PS F:\yourcode\xmake-androidcpp> xmake install -o build xmake-androidcpp
installing xmake-androidcpp ..
installing xmake-androidcpp to build ..
packing resources...
archiving libs...
align apk...
signing apk...
install ok!
PS F:\yourcode\xmake-androidcpp> xmake run xmake-androidcpp
[100%]: build ok, spent 0.031s
install apk...
run apk...
PS F:\yourcode\xmake-androidcpp>
```

### English

Develop Android Applications with Pure C/C++ Based on xmake

This repository is a sample project. The androidcpp folder is essential. AndroidManifest.xml is also necessary, and currently, it is not auto-generated.

Usage:
1. Set the target kind to shared.
2. Add a rule and configure relevant parameters.

Refer to xmake.lua syntax
```
includes("androidcpp")

target("xmake-androidcpp")
    add_rules("androidcpp", {android_sdk_version = "34", android_manifest = "AndroidManifest.xml", android_res = "res", android_assets = "assets", apk_output_path = ".", package_name = "com.xmake.androidcpp", activity_name = "android.app.NativeActivity"})
    set_kind("shared")
    add_files("src/*.c")
    add_syslinks("log", "android", "GLESv2", "EGL", "OpenSLES", "m")
```

xmake commands
```
xmake config -p android -a arm64-v8a
xmake build
xmake install -o build xmake-androidcpp
xmake run xmake-androidcpp
```

A typical command execution result is as follows
```
PS F:\yourcode\xmake-androidcpp> xmake config -p android -a arm64-v8a
PS F:\yourcode\xmake-androidcpp> xmake build
[100%]: build ok, spent 0.031s
PS F:\yourcode\xmake-androidcpp> xmake install -o build xmake-androidcpp
installing xmake-androidcpp ..
installing xmake-androidcpp to build ..
packing resources...
archiving libs...
align apk...
signing apk...
install ok!
PS F:\yourcode\xmake-androidcpp> xmake run xmake-androidcpp
[100%]: build ok, spent 0.031s
install apk...
run apk...
PS F:\yourcode\xmake-androidcpp>
```