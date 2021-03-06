# movieDB

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/69558ebebfb448268be114e51d5e59ab)](https://app.codacy.com/manual/timstudt/movieDB?utm_source=github.com&utm_medium=referral&utm_content=timstudt/movieDB&utm_campaign=Badge_Grade_Settings)
[![Build Status](https://app.bitrise.io/app/723504d1a6209d2a/status.svg?token=v50jaMCSRO84AXOvEyocoQ&branch=master)](https://app.bitrise.io/app/723504d1a6209d2a) [![codecov.io](https://codecov.io/gh/timstudt/movieDB/branch/master/graphs/badge.svg)](https://codecov.io/gh/timstudt/movieDB/branch/master)
[![docs](https://cdn.rawgit.com/timstudt/movieDB/master/docs/badge.svg)](https://cdn.rawgit.com/timstudt/movieDB/master/docs/index.html)
[![codebeat badge](https://codebeat.co/badges/563bdbae-0ac9-47ee-9ca6-4affd9062d39)](https://codebeat.co/projects/github-com-timstudt-moviedb-master)

## Installation

run `install.sh` to setup build environment and open `MovieDB.xcworkspace` with Xcode11.x

## 3rd Party Libs
- **Github Apps**
  - **CodeCov** - measures code coverage for unit tests
  - **Travis CI** - CI for iOS projects on Github
  - **CodeBeat** - code quality check
  - **bitrise** - CI/CD for mobile projects

- **Bundler** -
  - *Gemfile*
  - installed Gems:
    - **Travis** - CLI to run locally and access Travis-CI
      - *.travis.yml*
    - **Jazzy** (Realm) - autogenerates docs - [see Repo](https://github.com/realm/jazzy)
      - *.jazzy.yaml*
      - docs/*
    - **Fastlane** - CLI build/test/screenshots/deliver tool
      - *fastlane/Fastfile*
      - screenshots/*
    - **xcode-install** - CLI for Xcode tools
    - **xcpretty** - pretty/readable console print out for xcode output
    - ~**xctool** - FB tool to run all test targets~
    - **Danger** - automatic evaluation of Pull Requests  [Danger](https://github.com/danger/danger)
      - SwiftLint
      - xcov - [see Repo](https://github.com/fastlane-community/xcov)
    - **Cocoapods** - dependency management
      - *Podfile*
      - Pods/*

  - *Podfile*
  - installed Pods:
    - **Alamofire** - network layer for Swift projects
    - **Cocoapods-Keys** - saver way to handle API keys, private keys in xcode projects
    - **RxSwift** - Reactive programming in Swift
    - **Sourcery** - autogenerates boiler plate code (mocks, equatable, constructors)
      - *.sourcery.yml*
    - **SwiftLint** -  a tool to enforce Swift style and conventions - [see Repo](https://github.com/realm/SwiftLint)
      - *.swiftlint.yml*

  ***To Add***
   - ***Lottie***
   - ***Firebase*** - Google dev suite for tracking, notifications, crash reports...
   (- ***Taplytics*** - A/B-Testing)
   - ***Quick & Nimble*** - lib for unit tests

## Screenshots
generated screenshot for iPhone X; see *fastlane screenshots* lane

![screen](screenshots/en-US/iPhone%20X-0Launch.png)

## related articles about iOS App Architecture
- [agostini: Data Layer example iOS](https://agostini.tech/2017/03/27/using-dependency-injection/)
- [Dejan Atanasov: Clean architecture in Swift](https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf)
- [jobandtalent: View States in Swift](https://jobandtalent.engineering/ios-architecture-an-state-container-based-approach-4f1a9b00b82e)
