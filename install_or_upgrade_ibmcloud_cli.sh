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
mkdir -p ${HOME}/local/bin/cfcli

cp -f "bin/ibmcloud" "${HOME}/local/bin/"
cp -f "bin/ibmcloud-analytics" "${HOME}/local/bin/"
cp -f "bin/cfcli/cf" "${HOME}/local/bin/cfcli/cf"
cp -f "autocomplete/bash_autocomplete" "${HOME}/.bash_completion.d/ibmcloud_autocomplete"

cd /tmp
rm -fr "$temp_dir"

${HOME}/local/bin/ibmcloud config --usage-stats-collect false
${HOME}/local/bin/ibmcloud plugin install -f kubernetes-service
${HOME}/local/bin/ibmcloud plugin install -f cloud-functions
${HOME}/local/bin/ibmcloud plugin install -f container-registry
${HOME}/local/bin/ibmcloud plugin install -f vpc-infrastructure

echo "Be sure to set IKS_BETA_VERSION=1.0 for the latest and greatest experience"
echo "ibmcloud cli utility installed/upgraded to ${HOME}/local/bin"
echo "add it to your path to start using it"
