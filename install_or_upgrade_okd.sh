#!/bin/bash -x

echo "This script will install or upgrade your okd cli utility"
echo "This script has NO WARRANTY and is UNSUPPORTED"

temp_dir=$(mktemp -d)
slug=$(curl -s -L https://github.com/openshift/origin/releases/latest | grep tools | grep href | grep linux  | cut -d '"' -f 2)
linux_url="https://github.com/${slug}"

mkdir -p ${HOME}/local/usr/share/
mkdir -p ${HOME}/local/bin


cd $temp_dir
wget $linux_url
mv *.tar.gz linux64.tar.gz 
tar -xvzf linux64.tar.gz
cd openshift*

cp -f "kubectl" "${HOME}/local/bin/"
cp -f "oc" "${HOME}/local/bin/"
cp -f LICENSE ${HOME}/local/usr/share/okd-LICENSE
