# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
# declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
# warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# # Don't let testing shortcuts get into master by accident
# fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
# fail("fit left in tests") if `grep -r fit specs/ `.length > 1

# Run SwiftLint
def run_lint()
  swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
  swiftlint.verbose = true
  swiftlint.lint_all_files = true
  swiftlint.lint_files
end

# Xcode summary
def run_xcode_summary()
  # Ignoring warnings from Pods
  xcode_summary.ignored_files = 'Pods/**'
  # Ignoring specific warnings
  xcode_summary.ignored_results { |result|
    result.message.start_with?("ld") # Ignore ld_warnings
  }
  # Comment on each lines
  # xcode_summary.inline_mode = true
  xcode_summary.report 'build/reports/errors.json'
end

# Test Coverage report
def run_xcov()
  xcov.report(
    scheme: 'MovieDB',
    workspace: 'MovieDB.xcworkspace',
    include_targets: 'MovieDB.app',
    minimum_coverage_percentage: 55.0,
    include_test_targets: false,
    ignore_file_path: '.xcovignore',
    output_directory: 'danger_output/xcov_output'
  )
end

# MAIN
run_lint()
# run_xcode_summary() #buggy
run_xcov()
