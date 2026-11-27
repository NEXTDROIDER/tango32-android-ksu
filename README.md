<div align="center">

# Tango32 ARM64 Module

**Language:** 🇬🇧 English · [🇷🇺 Русский](README.ru.md)

**ARM32 compatibility support for ARM64-only Android kernels**

[![Build](https://github.com/NEXTDROIDER/tango32-android-ksu/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/NEXTDROIDER/tango32-android-ksu/actions/workflows/c-cpp.yml)
[![Architecture](https://img.shields.io/badge/architecture-ARM64-blue)](https://github.com/NEXTDROIDER/tango32-android-ksu)
[![Kernel](https://img.shields.io/badge/kernel-5.6%2B-informational)](https://github.com/NEXTDROIDER/tango32-android-ksu)
[![License](https://img.shields.io/badge/license-GPL--2.0-green)](COPYING)

<img src="assets/tango32-banner.svg" alt="Tango32 build pipeline" width="100%">

</div>

## About

This repository contains the Tango32 kernel module used by the [Tango binary translator](https://www.amanieusystems.com/). Tango translates 32-bit ARM programs so they can run on 64-bit-only ARM processors. The module provides kernel-side support for 32-bit system-call behavior that cannot be fully handled in userspace.

The module exposes its interface through ioctl operations on `/dev/tango32`.

> **Status:** builds are automated as compile-checks against selected kernel source. A successful compile is not proof that the module can be loaded on a device.

## Highlights

- ARM64 kernel-module build pipeline using Clang/LLVM.
- Select kernel repository, branch and exact target-device kernel release when starting a workflow.
- Refuse to build or publish a flashable package when the source `kernelrelease` differs from the requested device release.
- Device-model-labelled releases for successful builds.
- Releases are deduplicated by **device model + kernel source commit**.
- Build artifacts include the module, kernel config, kernel release, and build metadata.
- Vendor Kconfig entries absent from a source checkout are skipped only for the generic CI compile-check.

## Build in GitHub Actions

1. Open **[Actions → Tango32 ARM64 kernel module build](../../actions/workflows/c-cpp.yml)**.
2. Press **Run workflow**.
3. Enter a phone model (for example, `OPPO CPH2819`) or enter `all` to scan OPPO compatible identifiers in the selected kernel source's device tree.
4. Choose the kernel repository and branch.
5. Start the run and wait for compilation and release publishing.

Default source:
- Repository: `oppo-source/android_kernel_oppo_sm6225`
- Branch: `oppo/sm6225_b_16.0`

### Automatic releases

After a successful compile, normal mode creates a GitHub Release for the entered model. With `device_model=all`, the workflow scans the selected source's device-tree files for OPPO compatible identifiers and creates a separate release for each discovered identifier, skipping releases already published for that kernel commit. **This is identifier-based release labeling only: the module is compiled once for the selected source and is not independently validated for every listed device.** Tag format:

```
tango32-<device>-<kernel-release>-<commit>
```

Release assets:
- `tango32-<device>-kernelsu.zip` — installable KernelSU module (recommended)
- `tango32.ko` — compiled module
- `build-info.txt` — source, commit, compiler and build details
- `kernel-release.txt` — kernel release string
- `kernel-config.txt` — compile-check configuration
- `tango32-build-bundle.tar.gz` — bundled files

Browse **[Releases](../../releases)**.

### Is your phone missing from the releases?

If your phone model is not listed in the Releases, please **[open a new Issue](../../issues/new/choose)**. Include:

- Exact phone brand and model (for example, OPPO CPH2819).
- Android version and kernel version (`uname -r`).
- A link to the device's kernel source, if available.

We can use this information to investigate support and add a suitable build when the required kernel source is available. Creating an Issue does not guarantee that the device is supported or that a compatible module can be built.

### Install the KernelSU module

1. Download the device's `tango32-<device>-kernelsu.zip` from its GitHub Release.
2. Open KernelSU Manager → **Modules** → **Install from storage** and select the ZIP.
3. The installer checks ARM64 architecture and requires the phone's `uname -r` to exactly match the build's kernel release. If it differs, installation is stopped.
4. Reboot. The module attempts to load automatically at boot. Open its **Action** button in KernelSU to view status and logs.

The ZIP contains the module, installer checks, boot-time loader, status action and uninstall cleanup. A matching kernel release string is only a basic safety check; it does not prove that all kernel symbols/configuration match.

## Compatibility notes

- Upstream project notes Linux kernel **5.6 or newer** as the supported baseline; older kernels have partial/unsupported compatibility.
- This workflow prepares a generic ARM64 configuration and disables `CONFIG_MODVERSIONS` for compile-check. Therefore the output is **not guaranteed to load on your phone**.
- An installable module must be built against the exact device kernel source, configuration, toolchain, generated headers and symbol-version data.
- Do not force-load on a daily-use device without a recovery plan. Kernel modules can crash or boot-loop a device.

## Screenshots / build preview

There are no verified device screenshots yet. The banner above is an illustration of the build/release pipeline, not a screenshot of a running module. Real device screenshots and test results will be added when documented.

## Source & license

This repository is based on the Tango32 kernel-module source. See [COPYING](COPYING) for the license and [Amanieu Systems](https://www.amanieusystems.com/) for the translator.

---

<div align="center">Experimental · Android kernel development · ARM64</div>
