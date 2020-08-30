#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo " * Checking for phpMyAdmin installation"

# Download phpMyAdmin
if [[ ! -f /srv/www/default/database-admin/RELEASE-DATE-* ]]; then
    echo " * Removing older phpMyAdmin install from /srv/www/default/database-admin"
    rm -rf /srv/www/default/database-admin/*
    echo " * Downloading latest version of phpMyAdmin"
    cd /tmp
    wget -q -O phpmyadmin.zip "https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip"
    echo " * Extracting phpMyAdmin into /tmp"
    unzip phpmyadmin.zip
    echo " * Copying phpMyAdmin into place"
    mkdir -p /srv/www/default/database-admin
    cp -rf /tmp/phpMyAdmin*/* /srv/www/default/database-admin/
    echo " * Cleaning up after phpMyAdmin"
    rm -rf /tmp/phpMyAdmin*
    rm -f /tmp/phpmyadmin.zip
    echo " * phpMyAdmin setup complete"
else
    echo " * PHPMyAdmin already installed."
fi
cp -f "${DIR}/config.inc.php" "/srv/www/default/database-admin/"
