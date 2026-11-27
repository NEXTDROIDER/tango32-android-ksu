#!/system/bin/sh
MODDIR="${0%/*}"
LOG="/data/local/tmp/tango32-ksu.log"

{
  echo "[$(date)] Tango32 service starting"
  EXPECTED_RELEASE="$(cat "$MODDIR/kernel.release" 2>/dev/null)"
  CURRENT_RELEASE="$(uname -r)"
  if [ -z "$EXPECTED_RELEASE" ] || [ "$CURRENT_RELEASE" != "$EXPECTED_RELEASE" ]; then
    echo "SKIP: kernel mismatch (built=$EXPECTED_RELEASE device=$CURRENT_RELEASE)"
    exit 0
  fi

  if grep -q '^tango32 ' /proc/modules 2>/dev/null; then
    echo "Tango32 is already loaded"
    exit 0
  fi

  if insmod "$MODDIR/tango32.ko"; then
    echo "Tango32 loaded successfully"
  else
    result=$?
    echo "ERROR: insmod failed with exit code $result"
    dmesg | tail -n 40
  fi
} >> "$LOG" 2>&1
