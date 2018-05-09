#!/bin/sh

set -e
set -x

# Global variables
export LANG='C.UTF-8'

prove -Ilocal/lib/perl5
