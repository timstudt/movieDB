#!/bin/sh

./Pods/SwiftLint/swiftlint generate-docs > docs/swiftlint-generated-docs.md
bundle exec jazzy
