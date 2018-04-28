#!/bin/bash

#input:  lib/facter/service_provider.rb:1:
#output: https://github.com/puppetlabs/puppetlabs-stdlib/blob/master/lib/facter/service_provider.rb#L1
if [ -z $1 ]; then
    echo "Need argument"
    echo "Eg: lib/facter/service_provider.rb:11:stuff"
    exit 1
fi
filename=`echo $1 | cut -d ':' -f 1`
line=`echo $1 | cut -d ':' -f 2`

branch=`git branch | grep '*' | cut -d " " -f 2`
url=`git config --get remote.origin.url`
echo "${url}/blob/${branch}/${filename}#L${line}"

