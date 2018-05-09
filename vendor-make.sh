#!/bin/sh

rm -rf vendor/*

carton
carton bundle
carton fatpack

find vendor -name '*.tar.gz' | while read tgz; do
    (
        cd $(dirname $tgz)
        tar zxf $(basename $tgz)
        rm -f $(basename $tgz)
        name=$(perl -nale 'next unless /^name: /; s/^name: //; print' $(basename $tgz .tar.gz)/META.yml)
        mv -f $name-[0-9]* $name
    )
done
