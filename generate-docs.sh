#!/bin/sh

./Pods/SwiftLint/swiftlint generate-docs > docs/swiftlint-generated-docs.md
bundle exec jazzy

bundle outdated > docs/outdated-gems.md
bundle exec pod outdated > docs/outdated-pods.md
