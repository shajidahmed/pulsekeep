#!/bin/bash
# Prepare the existing native iPhone app for a personal Xcode build.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

if [[ "$(uname -s)" != Darwin ]]; then
    echo "Run this on a Mac with Xcode installed." >&2
    exit 1
fi
if ! xcodebuild -version >/dev/null 2>&1; then
    echo "Install Xcode 26 or later, launch it once, then select it with xcode-select." >&2
    exit 1
fi
if ! command -v xcodegen >/dev/null 2>&1; then
    echo "Install XcodeGen first: brew install xcodegen" >&2
    exit 1
fi

config_path="Config/BundleIdSecrets.xcconfig"
if [[ ! -e "$config_path" ]]; then
    # This file is gitignored; existing signing settings are never overwritten.
    printf '%s\n' 'BUNDLE_ID_PREFIX = com.shajidahmed.pulsekeep' > "$config_path"
fi

xcodegen generate
echo "Prepared Strand.xcodeproj. Open it in Xcode and select the NOOPiOS scheme."
echo "Choose your Apple Team in Signing & Capabilities for the app and embedded targets."
echo "Connect your iPhone, select it as the destination, then press Run."
echo "This prepares a build; it does not install an app or verify strap compatibility."
