# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'MovieDB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  plugin 'cocoapods-keys', {
    :project => "MovieDB",
    :keys => [
      "MovieDBApiKey"
    ]}

  # Pods for MovieDB
  pod 'Alamofire'
  # pod 'SwiftLint'
  # pod 'lottie-ios'
  # pod 'sourcery'
  # pod 'Firebase'

  target 'MovieDBTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MovieDBDataTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MovieDBUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
