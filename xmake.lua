includes("androidcpp")

target("flappybird")
    add_rules("androidcpp")
    set_kind("shared")
    add_files("*.c")
    add_syslinks("log", "android", "GLESv2", "EGL", "OpenSLES", "m")