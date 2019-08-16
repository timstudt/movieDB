fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios screenshots
```
fastlane ios screenshots
```
Generate new localized screenshots
### ios archive
```
fastlane ios archive
```
Builds and archives MovieDB, set clean:false for incremental build
### ios all_tests
```
fastlane ios all_tests
```

### ios generate_docs
```
fastlane ios generate_docs
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
