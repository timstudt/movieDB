import Danger

let danger = Danger()
let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

let changelogChanged = allSourceFiles.contains("CHANGELOG.md")
let sourceChanges = allSourceFiles.first(where: { $0.hasPrefix("Sources") })

if !changelogChanged && sourceChanges != nil {
    warn("No CHANGELOG entry added.")
}

if danger.git.linesOfCode > 500 {
    warn("Big PR, try to keep changes smaller if you can")
}

if !allSourceFiles.contains("*Tests/") {
    warn("The library files were changed, but the tests remained unmodified. Consider updating or adding to the tests to match the library changes.")
}
