#!/bin/bash

# to generate atom packages list, run:
#   apm list --installed --bare > atom-packages.list

# to generate atom config directory, run:
#   cd ~/.atom
#   cp *.{cson,coffee,less} /path/to/ubuntu-setup/resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ~/.atom
cp -r $DIR/../resources/atom ~/.atom

pushd .
cd /tmp
wget -O atom.deb https://atom.io/download/deb
sudo dpkg -i atom.deb
popd > /dev/null

apm install `cat $DIR/../resources/atom-packages.list`
