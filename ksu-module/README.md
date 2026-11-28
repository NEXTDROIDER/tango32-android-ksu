# Tango32 for KernelSU

Install the release ZIP in KernelSU Manager → Modules → Install from storage, then reboot.

The package includes:
- `tango32.ko` kernel module
- `tango32-install-apk` root helper for APK installation with low-target-SDK bypass
- **Tango32 Root Manager Android APK**, stored inside the module at `installer/Tango32Installer.apk`

At boot, `service.sh` attempts to load the module and install/update the bundled app with `pm install -r`. Android installs it as a regular app under `/data/app`. The package does **not** place the app in `/system`, `/system/app`, or another system partition path.

Logs: `/data/local/tmp/tango32-ksu.log`

The APK helper can also be called manually:
```sh
su -c 'tango32-install-apk /storage/emulated/0/Download/app.apk'
```

This is experimental. Kernel compatibility remains your responsibility.
