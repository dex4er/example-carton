#!/bin/sh

find vendor -name 'META.yml' | while read meta; do
    (
        cd $(dirname $(dirname $meta))
        name=$(basename $(dirname $meta))
        version=$(perl -nale 'next unless /^version: /; s/^version: //; s/[\x22\x27 ]*//g; print' $name/META.yml)
        if [ ! -f $name-$version.tar.gz ]; then
            cp -pR $name $name-$version
            tar zcf $name-$version.tar.gz $name-$version
            rm -rf $name-$version
        fi
    )
done

vendor/bin/carton install --deployment --cached
