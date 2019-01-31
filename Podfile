# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def moviedb_pods
    # Pods for MovieDB
    pod 'Alamofire'
    pod 'RxSwift',    '~> 4.0'
    # pod 'SwiftLint'
    # pod 'lottie-ios'
    # pod 'sourcery'
    # pod 'Firebase'
end

def project_pods
    pod 'SwiftLint'
end

def moviedb_tests
    pod 'RxBlocking', '~> 4.0'
end

target 'MovieDB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  moviedb_pods
  project_pods

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
    # Pods for testing
  end

  target 'MovieDBUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
