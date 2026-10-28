# Pulsekeep — personal WHOOP 5.0 iPhone development

This branch starts from `ryanbr/noop` commit `2a1de76`. Upstream authorship, license,
and notices are preserved. It is a personal development snapshot, not a verified
replacement for the WHOOP service. The hosted fork is [shajidahmed/pulsekeep](https://github.com/shajidahmed/pulsekeep).
An unsigned development IPA is available from
[iPhone package run #1](https://github.com/shajidahmed/pulsekeep/actions/runs/40657243447).
Apple ID signing and physical-device testing are still required.

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

1. Sign and install the development IPA on the actual iPhone. The cloud Mac and
   iPhone builds have passed; they do not establish physical-device operation.
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
Cloud compilation used GitHub Mac runners. The actual band and iPhone have not
been tested.

## Install the development package later

1. Download the `Pulsekeep-iPhone-unsigned-1` artifact from the successful build
   linked above, then unzip it on the Mac. It contains `Pulsekeep.ipa` and checksums.
2. Sign the IPA with the owner's Apple ID using the sideload workflow in
   [IOS.md](IOS.md). Apple credentials belong in the signing software, not in chat.
3. Install it on the iPhone. Select WHOOP 5.0/MG in the pairing flow and confirm
   live heart-rate reception before attempting overnight data collection.

The package includes the widget and omits the Watch app. It uses the distinct
`com.shajidahmed.pulsekeep.noop` identifier. Compile success does not establish
that deeper WHOOP 5.0 measurements are decoded correctly.
