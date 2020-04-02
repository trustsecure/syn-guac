#!/bin/sh
# This script is intended to be run on a Synology DiskStation. Tested on DS918+

echo "Preparing core directories"
mkdir ./init >/dev/null 2>&1
chmod -R +x ./init
mkdir ./cert-import >/dev/null 2>&1
mkdir ./nginx >/dev/null 2>&1
mkdir ./nginx/conf.d >/dev/null 2>&1
mkdir ./nginx/static >/dev/null 2>&1
echo "done"

echo "Preparing additional directories"
mkdir ./data >/dev/null 2>&1
mkdir ./drive >/dev/null 2>&1
mkdir ./record >/dev/null 2>&1
echo "done"

echo "Fetching files"
# Get the reset.sh script, and mark as executable.
wget "https://raw.githubusercontent.com/trustsecure/syn-guac/master/reset.sh"
chmod +x ./reset.sh
# Get the guacamole startup shim script, and mark as executable.
wget -O ./cert-import/install-cert-startup.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/cert-import/install-cert-startup.sh"
chmod +x ./cert-import/install-cert-startup.sh
# Get the nginx site configuration file.
wget -O ./nginx/conf.d/default.conf "https://raw.githubusercontent.com/trustsecure/syn-guac/master/nginx/conf.d/default.conf"
# Get the nginx static page file.
wget -O ./nginx/static/index.html "https://raw.githubusercontent.com/trustsecure/syn-guac/master/nginx/static/index.html"
# Get the docker-compose file for the stack.
wget "https://raw.githubusercontent.com/trustsecure/syn-guac/master/docker-compose.yml"
# Get the compose-up.sh script, and mark as executable.
wget "https://raw.githubusercontent.com/trustsecure/syn-guac/master/compose-up.sh"
chmod +x ./compose-up.sh
echo "done"

echo "Creating ./init/initdb.sql"
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql
echo "done"

echo "Copying DEFAULT syno-ca-cert.pem for import to container(s)"
chmod +x ./cert-import/install-cert-startup.sh
# Grab DiskStation's default certificate (make sure the AD SSL self-cert is set as the default!)
for i in `cat /usr/syno/etc/certificate/_archive/DEFAULT` ; do cp -f /usr/syno/etc/certificate/_archive/$i/syno-ca-cert.pem ./cert-import/ ; done
echo "done"

echo "************************************************************************"
echo " prepare.sh finished - check for errors above!"
echo "************************************************************************"
echo " You should customise the compose-up.sh file with organisation specific"
echo " passwords and other settings, then run it:"
echo " i.e."
echo " $ sudo ./compose-up.sh"
echo "************************************************************************"
