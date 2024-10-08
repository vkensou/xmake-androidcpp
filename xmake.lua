includes("androidcpp")

target("xmake-androidcpp")
    add_rules("androidcpp", {android_sdk_version = "34", android_manifest = "AndroidManifest.xml", android_res = "res", android_assets = "assets", apk_output_path = ".", package_name = "com.xmake.androidcpp", activity_name = "android.app.NativeActivity"})
    set_kind("shared")
    add_files("src/*.c")
    add_syslinks("log", "android", "GLESv2", "EGL", "OpenSLES", "m")