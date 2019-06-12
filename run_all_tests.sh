#!/bin/bash

WORKSPACE=MovieDB.xcworkspace
PLATFORM="platform=iOS Simulator,name=iPhone 8"

set -o pipefail

xcodebuild -scheme MovieDBTests -workspace "$WORKSPACE" -destination "$PLATFORM" test | xcpretty -f `xcpretty-json-formatter`;
xcodebuild -scheme MovieDBDataTests -workspace "$WORKSPACE" -destination "$PLATFORM" test | xcpretty -f `xcpretty-json-formatter`;

bundle exec danger dry_run #TODO remove for CI
