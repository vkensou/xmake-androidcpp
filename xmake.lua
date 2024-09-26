includes("androidcpp")

target("xmake-androidcpp")
    add_rules("androidcpp")
    set_kind("shared")
    add_files("src/*.c")
    add_syslinks("log", "android", "GLESv2", "EGL", "OpenSLES", "m")