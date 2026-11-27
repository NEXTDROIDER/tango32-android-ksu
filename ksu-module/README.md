# Tango32 for KernelSU

Install the ZIP from the KernelSU app (Modules → Install from storage), then reboot.

The installer checks that the device is ARM64 and that `uname -r` exactly matches the kernel release used for this build. The module's boot script loads `tango32.ko` with `insmod` and records the result in `/data/local/tmp/tango32-ksu.log`.

If the kernel release does not match, installation is refused. A matching release string is necessary but does not guarantee matching kernel configuration, exported symbols, compiler settings, or ABI. Do not bypass a failed load or force-load the module on a daily-use device.

Use the KernelSU Manager Action button to inspect load status and logs.
