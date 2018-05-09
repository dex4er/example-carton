#!/bin/sh

cd `dirname $0`/..
sh -x .ci/before_script.sh
sh -x "$1"
