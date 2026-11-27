#!/system/bin/sh
MODDIR="${0%/*}"
LOG="/data/local/tmp/tango32-ksu.log"
APK="$MODDIR/system/app/Tango32Installer/Tango32Installer.apk"
TMP="/data/local/tmp/Tango32Installer.apk"

{
  echo "[$(date)] Tango32 service starting"
  if grep -q '^tango32 ' /proc/modules 2>/dev/null; then
    echo "Tango32 already loaded"
  elif insmod "$MODDIR/tango32.ko"; then
    echo "Tango32 loaded successfully"
  else
    result=$?
    echo "ERROR: insmod failed with exit code $result"
    dmesg | tail -n 40
  fi

  if [ -s "$APK" ]; then
    cp "$APK" "$TMP"
    chmod 0644 "$TMP"
    restorecon "$TMP" 2>/dev/null || true
    echo "Installing bundled Tango32 Installer APK..."
    pm install --bypass-low-target-sdk-block -r "$TMP"
    install_result=$?
    rm -f "$TMP"
    if [ "$install_result" -eq 0 ]; then
      echo "Tango32 Installer installed/updated."
    else
      echo "WARNING: APK installation failed: $install_result"
    fi
  else
    echo "Installer APK missing from module."
  fi
} >> "$LOG" 2>&1
