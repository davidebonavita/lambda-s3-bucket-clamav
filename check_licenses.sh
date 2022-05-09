#!/bin/bash
# Check if license-checker is installed
if ! npm list -g | grep license-checker > /dev/null 2>&1; then
    echo "license-checker is not installed. Installing..."
    npm install -g license-checker
fi

# license-checker --excludePackages 'internal-1;internal-2'
FALSE_POSITIVES="node-forge@0.7.5;ckeditor4@4.18.0"

bad_licenses=$(license-checker --csv --excludePackages $FALSE_POSITIVES | grep "gpl\|GPL\|lgpl\|LGPL")
if [ "$bad_licenses" == "" ];then
   echo "No unacceptable licenses found"
else
   echo "Unacceptable licenses found:"
   echo $bad_licenses
   exit 1
fi
