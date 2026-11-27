# Tango32 for KernelSU

Install the ZIP from the KernelSU app (Modules → Install from storage), then reboot.

The installer checks that the device is ARM64. The module's boot script loads `tango32.ko` with `insmod` and records the result in `/data/local/tmp/tango32-ksu.log`. Kernel release mismatch checking is disabled in this experimental build.

## APK low-target-SDK bypass helper

The module installs `/system/bin/tango32-install-apk`. Run it as root to copy APKs out of shared storage into `/data/local/tmp` and install using Android's low-target-SDK bypass:

```sh
su -c 'tango32-install-apk /storage/emulated/0/Download/app.apk'
```

The helper uses `pm install --bypass-low-target-sdk-block -r`. This bypass only skips the minimum target-SDK installation block; it does not guarantee an old app will run correctly on modern Android.

Use the KernelSU Manager Action button to inspect load status and logs.
