#!/system/bin/sh
# KernelSU installer validation. This file is sourced by the KernelSU installer.
ui_print "- Tango32 KernelSU module"
ui_print "- Checking device architecture and kernel release..."

[ "$(uname -m)" = "aarch64" ] || abort "! This module requires an ARM64 (aarch64) device."
[ -f "$MODPATH/tango32.ko" ] || abort "! tango32.ko is missing."
[ -f "$MODPATH/kernel.release" ] || abort "! Build kernel.release metadata is missing."

EXPECTED_RELEASE="$(cat "$MODPATH/kernel.release" 2>/dev/null)"
CURRENT_RELEASE="$(uname -r)"
[ -n "$EXPECTED_RELEASE" ] || abort "! Invalid kernel.release metadata."
[ "$CURRENT_RELEASE" = "$EXPECTED_RELEASE" ] || abort "! Kernel mismatch. Built for: $EXPECTED_RELEASE; device: $CURRENT_RELEASE"

chmod 0644 "$MODPATH/tango32.ko" "$MODPATH/kernel.release"
chmod 0755 "$MODPATH/service.sh" "$MODPATH/action.sh" "$MODPATH/uninstall.sh"
ui_print "- Kernel release matches: $CURRENT_RELEASE"
ui_print "- Installed. Reboot to load Tango32."
