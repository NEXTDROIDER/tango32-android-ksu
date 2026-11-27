#!/system/bin/sh
if grep -q '^tango32 ' /proc/modules 2>/dev/null; then
  rmmod tango32 2>/dev/null || true
fi
