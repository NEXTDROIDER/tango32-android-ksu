#!/system/bin/sh
# KernelSU installer validation. This file is sourced by the KernelSU installer.
ui_print "- Tango32 KernelSU module"
ui_print "- Checking device architecture..."

[ "$(uname -m)" = "aarch64" ] || abort "! This module requires an ARM64 (aarch64) device."
[ -f "$MODPATH/tango32.ko" ] || abort "! tango32.ko is missing."
[ -f "$MODPATH/system/bin/tango32-install-apk" ] || abort "! APK bypass installer is missing."

chmod 0644 "$MODPATH/tango32.ko" "$MODPATH/kernel.release"
chmod 0755 "$MODPATH/service.sh" "$MODPATH/action.sh" "$MODPATH/uninstall.sh" "$MODPATH/system/bin/tango32-install-apk"
ui_print "- Kernel release compatibility check disabled."
ui_print "- Added tango32-install-apk (low-target SDK bypass)."
ui_print "- Installed. Reboot to load Tango32."
