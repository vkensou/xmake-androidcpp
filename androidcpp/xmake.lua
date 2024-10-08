rule("androidcpp")
    if is_plat("android") then 
        after_install(function (target)
            local android_sdk_version = target:extraconf("rules", "androidcpp", "android_sdk_version")
            local android_manifest = target:extraconf("rules", "androidcpp", "android_manifest")
            local android_res = target:extraconf("rules", "androidcpp", "android_res")
            local android_assets = target:extraconf("rules", "androidcpp", "android_assets")
            local keystore = target:extraconf("rules", "androidcpp", "keystore") or path.join("androidcpp", "xmake-debug.jks")
            local keystore_pass = target:extraconf("rules", "androidcpp", "keystore_pass") or "123456"
            local apk_output_path = target:extraconf("rules", "androidcpp", "apk_output_path") or "."
            local attachedjar = target:extraconf("rules", "androidcpp", "attachedjar")

            assert(android_sdk_version, "android sdk version not set")
            assert(android_manifest, "android manifest not set")

            import("android_build")(target, android_sdk_version, android_manifest, android_res, android_assets, attachedjar, keystore, keystore_pass, apk_output_path)
        end)

        on_run(function (target)
            local apk_output_path = target:extraconf("rules", "androidcpp", "apk_output_path") or "."
            local package_name = target:extraconf("rules", "androidcpp", "package_name")
            local activity_name = target:extraconf("rules", "androidcpp", "activity_name")

            assert(package_name, "package name not set")
            assert(activity_name, "activity name not set")

            import("android_run")(target, apk_output_path, package_name, activity_name)
        end)
    end 
