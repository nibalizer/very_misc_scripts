#!/bin/bash

echo "This script will install or upgrade your ibmcloud cli utility"
echo "This script has NO WARRANTY and is UNSUPPORTED"

temp_dir=$(mktemp -d)
linux_url="https://clis.ng.bluemix.net/download/bluemix-cli/latest/linux64"

cd $temp_dir
wget $linux_url
mv linux64 linux64.tar.gz 
tar -xvzf linux64.tar.gz
cd Bluemix_CLI/

cp -f "bin/ibmcloud" "${HOME}/local/bin/"
cp -f "bin/ibmcloud-analytics" "${HOME}/local/bin/"
cp -f "autocomplete/bash_autocomplete" "${HOME}/.bash_completion.d/ibmcloud_autocomplete"

cd /tmp
rm -fr "$temp_dir"

${HOME}/local/bin/ibmcloud config --usage-stats-collect false
${HOME}/local/bin/ibmcloud plugin install -f kubernetes-service

echo "ibmcloud cli utility installed/upgraded to ${HOME}/local/bin"
echo "add it to your path to start using it"

