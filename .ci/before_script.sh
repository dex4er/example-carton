#!/bin/sh

set -e
set -x

# Prerequisities

# Global variables
export DEBIAN_FRONTEND='noninteractive'
export LANG='C.UTF-8'

# APT
. /usr/lib/os-release
RELEASE=`echo $VERSION | sed 's/.*(\(.*\)).*/\1/'`

apt-get update
apt-get -y install build-essential ca-certificates curl
apt-get -y install liblocal-lib-perl

eval $(perl -Mlocal::lib)

curl -k -L cpanmin.us | perl - App::cpanminus
cpanm -n App::FatPacker Carton ExtUtils::MakeMaker File::pushd Socket Try::Tiny

./vendor-make.sh

eval $(perl -Mlocal::lib=--deactivate-all)
rm -rf local

./vendor-install.sh
