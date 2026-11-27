#!/system/bin/sh
# KernelSU module installer
ui_print "- Tango32 KernelSU module"
ui_print "- Checking device architecture..."
[ "$(uname -m)" = "aarch64" ] || abort "! ARM64 (aarch64) is required."
[ -f "$MODPATH/tango32.ko" ] || abort "! tango32.ko missing."
[ -f "$MODPATH/system/bin/tango32-install-apk" ] || abort "! APK helper missing."
[ -s "$MODPATH/system/app/Tango32Installer/Tango32Installer.apk" ] || abort "! Tango32 Installer APK missing."
chmod 0644 "$MODPATH/tango32.ko" "$MODPATH/kernel.release" "$MODPATH/system/app/Tango32Installer/Tango32Installer.apk"
chmod 0755 "$MODPATH/service.sh" "$MODPATH/action.sh" "$MODPATH/uninstall.sh" "$MODPATH/system/bin/tango32-install-apk"
ui_print "- Tango32 kernel module"
ui_print "- APK bypass helper"
ui_print "- Bundled Tango32 Installer app"
ui_print "- Installed. Reboot to load module and install/update app."
