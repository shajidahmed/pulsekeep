# Pulsekeep — personal WHOOP 5.0 iPhone development

This branch starts from `ryanbr/noop` commit `2a1de76`. Upstream authorship, license,
and notices are preserved. It is a personal development snapshot, not a verified
replacement for the WHOOP service. The hosted fork is [shajidahmed/pulsekeep](https://github.com/shajidahmed/pulsekeep).
No installable Pulsekeep release has been created yet.

## Changes

- Config readback no longer treats multi-character text such as `10`, `100`, or
  `0.0` as the single flag value `1` or `0`. This prevents a false confirmation in
  the existing setting-verification paths. Swift and Kotlin have matching changes.
- Regression cases exercise CRC-valid WHOOP 5 readback frames with the complete
  revision/key/value record, rather than bypassing the decoder.
- A Mac preparation helper generates the existing native iPhone project with a
  separate personal bundle prefix, preserving any existing local signing config.

## Build on a Mac

Install Xcode 26 or later and XcodeGen. In Terminal, from this folder:

```bash
bash Tools/prepare-personal-ios.sh
open Strand.xcodeproj
```

Select `NOOPiOS`, choose the connected iPhone, and select the appropriate Apple
Team in Signing & Capabilities for the app and embedded targets. See
[IOS.md](IOS.md) for signing and sideloading details. Apple credentials stay in
Xcode; they are not needed in chat.

## Remaining work and evidence required

1. Compile and test the full Apple targets with Xcode. Linux package tests do not
   compile the native iPhone UI or CoreBluetooth integration.
2. Pair with the actual WHOOP 5.0 and record its firmware, negotiated connection,
   and data types received. Keep personal health captures private.
3. Verify history offload and live collection separately, including background
   operation, screen lock, disconnects, and app relaunch.
4. Compare multiple nights of recorded signals against the owner's export.
   Validate units, timestamps, missing intervals, and changing physiological
   values before feeding new fields into scoring.
5. Implement missing mappings only from captured evidence. Unknown optical bytes
   cannot be presented as calibrated blood oxygen or reliable sleep stages.

## Code-review findings to resolve before experimental writes

The baseline documentation for firmware 50.42.1.0 describes a 65-byte named SET
body, while `Whoop5Config` still emits shorter legacy bodies. It also documents
per-key tri-state semantics that differ from the historical “enable” recipe's
assumptions. No setting encoders, flag values, or automatic connection commands
have been changed here. Resolve the firmware-specific contract, existing value
readback, and reversibility before enabling new writes.

## Validation status

See `PERSONAL_VALIDATION.md` for the checks actually run on this snapshot.
No physical band, iPhone, or Mac was available for hardware testing.
