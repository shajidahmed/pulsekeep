# Validation of the personal development snapshot

Checks were run on Linux with Swift 6.1.3 and Kotlin 2.0.21/JDK 17.

| Check | Result |
|---|---|
| Full `WhoopProtocol` Swift package suite, including the readback regression | 858 tests executed; one skipped; zero failures |
| Swift gate suite after adding the cross-platform oracle test | 21 tests; zero failures |
| Kotlin `DeviceConfigWriteGateTest` and `DeviceConfigReadProbeTest`, compiled directly on the JVM | 52 tests; zero failures |
| Standalone Swift accessor oracle for `1`, `0`, `2`, `10`, `100`, `1.0`, `00`, `0.0`, `0.5` | `49, 48, 50, null, null, null, null, null, null`; pinned in both platform tests |
| Repository parity ledger | No new findings |
| Detached documentation comment check | No new findings |
| Mac helper shell syntax | Passed `bash -n` |
| Whitespace/diff check | Passed `git diff --check` |

The full Swift count predates the additional oracle test; the subsequent targeted
run covers that addition. Kotlin checks cover the pure readback/gate code and
its dependencies, excluding the Android data-layer historical-stream adapter;
they are not a Gradle app build. These checks establish the readback correction,
not overall device compatibility.

At the original snapshot, the Apple checks below had not run. Still unverified:
iPhone installation, Apple provisioning/signing, Bluetooth
pairing, firmware-specific data capture, overnight collection, background
reconnection, or physiological accuracy validation. These require the actual iPhone and band. A cloud build does not establish
physical-device operation.

## Apple build verification — 28 October 2026

[Apple build run #1](https://github.com/shajidahmed/pulsekeep/actions/runs/40656966464)
completed successfully on source commit `c64ef8b`:

- macOS universal build (`x86_64` and `arm64`): passed.
- macOS app-target suite: 2,302 tests executed, two skipped, zero failures.
- iPhone simulator app build: passed; this leg does not run iPhone tests.

The subsequent commit `8f5338a` adds only the dedicated iPhone packaging workflow;
its application source is unchanged. The physical-device Release build and packaging also passed in
[iPhone package run #1](https://github.com/shajidahmed/pulsekeep/actions/runs/40657243447)
on `8f5338a`.

The iPhone package checks confirmed an arm64 iPhoneOS app, matching app/widget
App Groups, the Pulsekeep display name and personal bundle identifier, Bluetooth
background mode, and a valid replaceable ad-hoc capability signature. This is
not Apple distribution signing or proof of successful installation.

The downloaded archive and inner IPA were verified locally against their SHA-256
checksums. The IPA's checksum is:

```text
899f9a88c83c2f44ef1a4ccd795b124af5e52f1b3c91988f292c216023b49af6
```

The artifact includes `Pulsekeep.ipa`, `SHA256SUMS.txt`, and `BUILD-INFO.txt`.
GitHub retains the artifact for 30 days. No Apple signing credentials were used.
Hardware pairing, background collection and physiological accuracy remain untested.
