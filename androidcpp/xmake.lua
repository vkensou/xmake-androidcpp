option("android_sdk_version")
    set_default("30")

rule("androidcpp")
    if is_plat("android") then 
        on_load(function (target)
            target:add("options", "android_sdk_version")
            target:add("files", "androidcpp/*.c")
            target:add("includedirs", "androidcpp")
        end)

        after_build(function (target)
            local android_sdk_version = target:get("config", "android_sdk_version") or "33"
            local android_manifest = "AndroidManifest.xml"
            local android_res = "res"
            local android_assets = "assets"
            local keystore = "mykeystore.jks"
            local keystore_pass = "12345678"
            local apk_output_path = "."
            import("android_build")(target, android_sdk_version, android_manifest, android_res, android_assets, keystore, keystore_pass, apk_output_path)
        end)
    end 
