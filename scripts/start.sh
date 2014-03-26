#!/bin/bash

usage="start.sh <domain> <secret>"

if [ $# -ne 2 ]; then
    echo "No parameter passed, not starting pagekite. Usage:";
    echo $usage
else
    domain=$1
    secret=$2
    echo "Connecting pagekite.";
    backend_config="domain=https:${domain}:${secret}"
    echo $backend_config > /etc/pagekite.d/20_backend.rc
fi

cd cockpit

# start pagekite backend daemon
sudo service pagekite start

# the app
node cockpit.js
