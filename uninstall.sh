#!/bin/bash
echo "WARNING: you're about to uninstall cocoapods, Bundler, rbenv and brew. Continue?[y,N]"
read UserInput
if [[ $UserInput != "y" ]]; then
  echo "uninstall cancelled."
  exit 1
fi

# remove CocoaPods, gem is removed with rbenv (~/.rbenv/versions/<version>/)
echo "clean up Pods......"
rm -fr Pods
rm -fr ~/.cocoapods/*

# remove Bundler
echo "clean up Bundler......"
rm -fr ~/.bundle/*

# remove rbenv and all installed gems
echo "clean up rbenv and all it's gems......"
brew remove rbenv
rm -rf ~/.rbenv
sed -n -i '.bak' '/rbenv/!p' ~/.bash_profile
source ~/.bash_profile
export PATH=`echo $PATH | awk -v RS=: -v ORS=: '/rbenv/ {next} {print}'` # rm rbenv path

#remove brew, uninstall brew and cache and all formula
echo "clean up brew......"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
