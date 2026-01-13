# Uncomment the next line to define a global platform for your project
platform :ios, '18.0'

def moviedb_pods
    # Pods for MovieDB
    pod 'Alamofire'
    pod 'RxSwift', '~> 6.6'
    pod 'RxCocoa', '~> 6.6'
    # pod 'lottie-ios'
    # pod 'Firebase'
end

def project_pods
    # SwiftLint: prefer installing via Homebrew for Xcode 26 (faster updates and CI-friendly).
    # If you must use the CocoaPod, uncomment and use a recent version:
    # pod 'SwiftLint', '~> 0.53'
    pod 'Sourcery', '~> 0.16.1'
    # pod 'Stencil', '~> 0.8.0'
end

def moviedb_tests
    pod 'RxBlocking', '~> 5.0'
end


target 'MovieDB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  moviedb_pods
  project_pods

  script_phase :name => 'SwiftLint', :script => 'SWIFTLINT_BINARY="$(which swiftlint || echo ${PODS_ROOT}/SwiftLint/swiftlint)" && $SWIFTLINT_BINARY', :execution_position => :before_compile

  plugin 'cocoapods-keys', {
    :project => "MovieDB",
    :keys => [
      "MovieDBApiKey"
    ]}

  target 'MovieDBTests' do
    inherit! :search_paths
    moviedb_tests
    # Pods for testing
  end

  target 'MovieDBDataTests' do
    inherit! :search_paths
    moviedb_tests
    script_phase :name => 'Sourcery', :script => '${PODS_ROOT}/Sourcery/bin/sourcery --config ${SRCROOT}/.sourcery.yml', :execution_position => :before_compile
  end

  target 'MovieDBUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
