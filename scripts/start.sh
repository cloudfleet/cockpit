#!/bin/bash

usage="start.sh <domain> <secret> [frontend]\n\
e.g. start.sh test.blimpyard.cloudfleet.io supersecret blimpyard.cloudfleet.io:1234"

if [ $# -lt 2 ]; then
    echo "No parameter passed, not starting pagekite. Usage:";
    echo $usage
else
    domain=$1
    secret=$2
    echo "Connecting pagekite.";

    # account
    account_rc="kitename = ${domain}\nkitesecret = ${secret}"
    echo -e $account_rc > /etc/pagekite.d/10_account.rc

    # frontend
    frontend=${3:-blimpyard.cloudfleet.io:60666}
    frontend_rc="frontend = ${frontend}"
    echo $frontend_rc > /etc/pagekite.d/20_frontends.rc

    # httpd
    httpd_rc="service_on = http:@kitename : localhost:3000 : @kitesecret"
    echo $httpd_rc > /etc/pagekite.d/80_httpd.rc
fi

cd $HOME/cockpit

# start pagekite backend daemon
#sudo service pagekite start
sudo invoke-rc.d pagekite restart

# the app
authbind node cockpit.js
