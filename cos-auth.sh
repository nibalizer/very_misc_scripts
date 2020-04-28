#!/bin/bash
# Apache 2.0 License
# No warranty

# This script is a helper to handle authentication to a cos instance

cos_instance=$1
if [ -z "${1}" ]; then
    echo "Please provide the name of the cos instance you intend to auth to"
    exit 1
fi

if [ ! -z "${2}" ]; then
    echo "Please quote the name of the cos instance you intend to auth to"
    exit 1
fi

echo "Authing you to ${cos_instance}"

cos_crn=$(ibmcloud resource service-instance "${cos_instance}" --id  | grep 'crn:v1' | cut -d " " -f 2)

ibmcloud cos config crn --crn "${cos_crn}" --force
