# Tango32 for KernelSU

Install the release ZIP in KernelSU Manager → Modules → Install from storage, then reboot.

The package includes:
- `tango32.ko` kernel module
- `tango32-install-apk` root helper for APK installation with low-target-SDK bypass
- **Tango32 Installer Android app APK**, bundled in `system/app/Tango32Installer/`

At boot, `service.sh` attempts to load the module and install/update the bundled app using:
`pm install --bypass-low-target-sdk-block -r`

Logs: `/data/local/tmp/tango32-ksu.log`

The APK helper can also be called manually:
```sh
su -c 'tango32-install-apk /storage/emulated/0/Download/app.apk'
```

This is experimental. Low target-SDK bypass does not make unsupported apps function on modern Android. Kernel compatibility remains your responsibility.
