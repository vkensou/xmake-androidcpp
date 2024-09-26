function main(target, android_sdk_version, android_manifest, android_res, android_assets, keystore, keystore_pass, apk_output_path)
    local outputpath = path.join("build", "android", "output")
    if os.exists(outputpath) then
        os.rmdir(outputpath)
    end
    local outputtemppath = path.join(outputpath, "temp")
    os.mkdir(outputtemppath)
    local libpath = path.join(outputpath, "lib")
    os.mkdir(libpath)
    local libarchpath = path.join(libpath, target:arch())
    os.mkdir(libarchpath)
    os.cp(target:targetfile(), libarchpath)

    import("core.tool.toolchain")

    local toolchain_ndk = toolchain.load("ndk", {plat = target:plat(), arch = target:arch()})

    -- get ndk
    local ndk = path.translate(assert(toolchain_ndk:config("ndk"), "cannot get NDK!"))

    -- get android sdk directory
    local android_sdkdir = path.translate(assert(toolchain_ndk:config("android_sdk"), "please run `xmake f --android_sdk=xxx` to set the android sdk directory!"))

    -- get android build-tools version
    local android_build_toolver = assert(toolchain_ndk:config("build_toolver"), "please run `xmake f --build_toolver=xxx` to set the android build-tools version!")

    local aapt = path.join(android_sdkdir, "build-tools", android_build_toolver, "aapt" .. (is_host("windows") and ".exe" or ""))

    local resonly_apk = path.join(outputtemppath, "res_only.zip")
    local aapt_argv = {"package", "-f",
        "-M", android_manifest,
        "-S", android_res,
        "-A", android_assets,
        "-I", path.join(android_sdkdir, "platforms", string.format("android-%s", android_sdk_version), "android.jar"),
        "-F", resonly_apk
    }

    print("packing resources...")
    os.vrunv(aapt, aapt_argv)

    import("lib.detect.find_tool")
    local zip = find_tool("7z")
    assert(zip, "zip not found!")
    local zip_argv = { "a", "-tzip", "-r", 
        resonly_apk,
        path.join(".", libpath)
    }

    print("archiving libs...")
    os.vrunv(zip.program, zip_argv)

    local aligned_apk = path.join(outputtemppath, "unsigned.apk")
    local zipalign = path.join(android_sdkdir, "build-tools", android_build_toolver, "zipalign" .. (is_host("windows") and ".exe" or ""))
    local zipalign_argv = {
        "-f", "4",
        resonly_apk, aligned_apk
    }

    print("align apk...")
    os.vrunv(zipalign, zipalign_argv)

    local final_output_path = outputtemppath
    local final_apk = path.join(final_output_path, target:basename() .. ".apk")
    local apksigner = path.join(android_sdkdir, "build-tools", android_build_toolver, "apksigner" .. (is_host("windows") and ".bat" or ""))
    local apksigner_argv = {
        "sign", 
        "--ks", keystore,
        "--ks-pass", string.format("pass:%s", keystore_pass),
        "--out", final_apk, 
        "--in", aligned_apk
    }

    print("signing apk...")
    os.vrunv(apksigner, apksigner_argv)

    if apk_output_path then
        os.mv(final_apk, apk_output_path)
    end
end