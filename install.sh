#!/bin/sh

RUBY_VERSION=2.4.5 #$RBENV_VERSION
MIN_GEM_VERSION=2.5.0
BUNDLER_VERSION=2.0.2
XCODE_SELECT_VERSION=2370
# RUBY_PATH=~/.gem/ruby/2.4.0/bin

set -eo pipefail

current_ruby_version()
{
  echo "`rbenv version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/'`"
}

ruby_version_exists()
{
  current_ruby_version | grep $RUBY_VERSION
}

current_bundler_version()
{
  echo "`bundle -v | sed 's/[[:alpha:]|(|[:space:]]//g'`"
}

current_xcode_version()
{
  echo "`xcode-select -v | sed 's/[^0-9]*//g'`"
}

install_brew()
{
  HOMEBREW_VERSION=`brew -v || true`
  echo "*** current homebrew: $HOMEBREW_VERSION"
  if [[ -z $HOMEBREW_VERSION ]]; then
    echo "*** installing homebrew..."
    : | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    chown -R $(whoami) /usr/local/Homebrew
  else
    echo "   --> all good"
    brew update || brew update
  fi
  # brew doctor
}

install_custom_ruby()
{
  RBENV_VERSION=`rbenv -v || true`
  echo "*** current ruby env version: $RBENV_VERSION"

  if [[ -z $RBENV_VERSION ]]; then
    echo "*** installing rbenv..."
    brew install rbenv
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bash_profile
  else
    echo "   --> all good"
    brew outdated rbenv || brew upgrade rbenv
  fi

  VERSION=$( current_ruby_version )
  echo "*** current ruby version: $VERSION"

  if [[ $VERSION != $RUBY_VERSION ]]; then
    echo "*** installing ruby verions: $RUBY_VERSION"
    rbenv install -s # installs version from .ruby-version; + ruby-build as dependency
    rbenv local $RUBY_VERSION
    rbenv rehash #updates the shim for the bundle binary
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
  echo "*** gem install path: `gem env home`"

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
    gem install bundler $BUNDLER_VERSION || true
  else
    echo "   --> all good"
  fi
}

# install xocde cli
install_xcode_select()
{
  CURRENT_XCODE_VERSION=$( current_xcode_version )
  echo "*** current Xcode cli version: $CURRENT_XCODE_VERSION"
  if [[ -z $CURRENT_XCODE_VERSION ]]; then
    echo "*** installing xcode-select"
    `xcode-select --install || true`
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
install_xcode_select
install_custom_ruby
install_gems
install_bundler
# install_packages
install_pods
# list_simulators
