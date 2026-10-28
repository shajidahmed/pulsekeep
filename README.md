# Pulsekeep

**Your rhythm. Your records.**

Pulsekeep is a personal iPhone companion for WHOOP 5.0, forked from
[NOOP by ryanbr and its contributors](https://github.com/ryanbr/noop).
It develops direct Bluetooth collection and local analytics while keeping health
records on the device by default.

## Development status

This is a development fork. An **unsigned iPhone development package** is available
from [iPhone build #1](https://github.com/shajidahmed/pulsekeep/actions/runs/40657243447).
It requires signing with your own Apple ID before installation.
WHOOP 5.0 support remains experimental: live heart rate is reported working
upstream, but complete overnight signals, sleep staging, recovery inputs, and
background collection still require testing on the actual band and iPhone.
Derived scores are independent estimates, not WHOOP's proprietary analytics.

## Changes in this fork

- Fixed single-byte configuration readback so values such as `10` and `0.0`
  cannot be misreported as the flag `1` or `0`.
- Added matching Swift/Kotlin regression cases and a shared scalar-value oracle.
- Added a Mac preparation helper with a separate personal bundle prefix.
- Set the Apple app display name to **Pulsekeep**, preserving internal target
  names so existing build schemes continue to resolve.

## Build for iPhone

On a Mac with Xcode 26 or later and XcodeGen installed:

```bash
git clone https://github.com/shajidahmed/pulsekeep.git
cd pulsekeep
bash Tools/prepare-personal-ios.sh
open Strand.xcodeproj
```

Choose the **NOOPiOS** scheme, select your iPhone and your Apple signing Team,
then Run. Xcode generates the project and Info.plist values from `project.yml`.
See [personal setup](docs/PERSONAL_IPHONE.md) and the
[upstream iOS build guide](docs/IOS.md) for details.

## Validation

The protocol package suite executed 858 tests with one skipped and zero failures.
A subsequent gate suite ran 21 tests, and the matching Kotlin suites ran 52;
all passed. See [validation details and limits](docs/PERSONAL_VALIDATION.md).
The Mac universal build, 2,302 app-target tests (two skipped, zero failures),
iPhone simulator build, and iPhone device Release packaging have also passed.
Physical-band testing is still pending.

## Attribution and license

Pulsekeep is an independent personal fork, not affiliated with WHOOP or endorsed
by NOOP's maintainers. It retains the upstream
[PolyForm Noncommercial 1.0.0 license](LICENSE), [notices](NOTICE),
[credits](ATTRIBUTION.md), and [disclaimer](DISCLAIMER.md).
The [original upstream README](README.upstream.md) is preserved for reference;
its release links and compatibility claims refer to NOOP, not Pulsekeep releases.
