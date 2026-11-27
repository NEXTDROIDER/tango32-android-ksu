#!/system/bin/sh
MODDIR="${0%/*}"
echo "Tango32 KernelSU module"
echo "Built for: $(cat "$MODDIR/kernel.release" 2>/dev/null)"
echo "Device:    $(uname -m) / $(uname -r)"
if grep -q '^tango32 ' /proc/modules 2>/dev/null; then
  echo "Status: LOADED"
else
  echo "Status: NOT LOADED"
fi
echo
echo "Recent module log:"
tail -n 40 /data/local/tmp/tango32-ksu.log 2>/dev/null || true
echo
echo "Recent kernel messages:"
dmesg | grep -i tango32 | tail -n 30 2>/dev/null || true
