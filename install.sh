#!/bin/sh

RUBY_VERSION=2.4.5
MIN_GEM_VERSION=2.5.0
BUNDLER_VERSION=2.0.2

current_ruby_version()
{
  echo "`rbenv version | sed 's/[[:alpha:]|(|[:space:]]//g'`"
}

current_bundler_version()
{
  echo "`bundle -v | sed 's/[[:alpha:]|(|[:space:]]//g'`"
}

install_brew()
{
  HOMEBREW_VERSION=`brew -v`
  echo "*** current homebrew: $HOMEBREW_VERSION"
  if [[ -z $HOMEBREW_VERSION ]]; then
    echo "*** installing homebrew..."
    : | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "   --> all good"
  fi
}

install_custom_ruby()
{
  RBENV_VERSION=`rbenv -v`
  echo "*** current ruby env version: $RBENV_VERSION"

  if [[ -z $RBENV_VERSION ]]; then
    echo "*** installing rbenv..."
    brew install rbenv
  else
    echo "   --> all good"
  fi

  eval "$(rbenv init -)"


  VERSION=$( current_ruby_version )
  echo "*** current ruby version: $VERSION"

  if [[ -z $VERSION ]]; then
    echo "*** installing ruby verions: $RUBY_VERSION"
    rbenv install $RUBY_VERSION
    rbenv rehash #updates the shim for the bundle binary
    rbenv local $RUBY_VERSION #use version in current path
    export PATH="~/.rbenv/versions/$RUBY_VERSION/bin:$PATH"
  else
    echo "   --> all good"
  fi
}

# install Gems
install_gems()
{
  CURRENT_RUBY_VERSION=`ruby --version`
  CURRENT_GEM_VERSION=`gem --version`

  echo "*** ruby version: $CURRENT_RUBY_VERSION"
  echo "*** gem version: $CURRENT_GEM_VERSION"

  if [[ $CURRENT_GEM_VERSION < $MIN_GEM_VERSION ]]
  then
    echo "*** upgrading ruby gems..."
    gem update --system
  else
    echo "   --> all good"
  fi


  CURRENT_BUNDLER_VERSION=$( current_bundler_version )
  echo "*** current Bundler version: $CURRENT_BUNDLER_VERSION"
  if [[ $CURRENT_BUNDLER_VERSION < $BUNDLER_VERSION ]]; then
    echo "*** installing Bundler..."
    gem install bundler $BUNDLER_VERSION
  else
    echo "   --> all good"
  fi
}

# install Bundler - see Gemfile
install_bundler()
{
  echo "*** installing Gems with Bundler..."
  bundle install
}

# install Danger-swift
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
  echo "*** installing Pods..."
  bundle exec pod env #debug
  bundle exec pod keys set MovieDBApiKey $MOVIE_DB_API_KEY MovieDB
  bundle exec pod install --repo-update
}

# MAIN
set -o pipefail
echo "*** installing build environment..."
install_brew
install_custom_ruby
install_gems
install_bundler
# install_packages
install_pods
# list_simulators
