#!/bin/sh

# install Gems
install_gems()
{
  gem --version
  gem install bundler
}

# install Bundler - see Gemfile
install_bundler()
{
  bundle install
  bundle
}

# install Danger
install_packages()
{
  swift build
}

#- bundle exec pod keys #debug
list_simulators()
{
  xcrun simctl list
}

# install CocoaPods - see Podfile
install_pods()
{
  bundle exec pod env #debug
  bundle exec pod keys set MovieDBApiKey $MOVIE_DB_API_KEY MovieDB
  bundle exec pod install --repo-update
}

# MAIN
set -o pipefail
install_gems
#install_bundler #obsolete: using Gems
install_packages
install_pods
list_simulators
