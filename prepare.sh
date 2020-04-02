#!/bin/sh
# This script is intended to be run on a Synology DiskStation. Tested on DS918+

echo "Preparing directory structure..."
mkdir ./scripts >/dev/null 2>&1
mkdir ./cert-import >/dev/null 2>&1

mkdir ./database >/dev/null 2>&1
mkdir ./database/init >/dev/null 2>&1
mkdir ./database/data >/dev/null 2>&1
chmod -R +x ./database/init

mkdir ./guacamole >/dev/null 2>&1
mkdir ./guacamole/conf >/dev/null 2>&1
mkdir ./guacamole/entrypoint >/dev/null 2>&1
mkdir ./guacamole/drive >/dev/null 2>&1
mkdir ./guacamole/record >/dev/null 2>&1

mkdir ./nginx >/dev/null 2>&1
mkdir ./nginx/conf.d >/dev/null 2>&1
mkdir ./nginx/static >/dev/null 2>&1
echo "done"

echo "Fetching files.."
# Get the guacamole entrypoint script, and mark as executable.
wget -nv -O ./guacamole/entrypoint/certimport-entrypoint.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/guacamole/entrypoint/certimport-entrypoint.sh"
chmod +x ./guacamole/entrypoint/certimport-entrypoint.sh

# Get the Tomcat configuration file.
wget -nv -O ./guacamole/conf/server.xml "https://raw.githubusercontent.com/trustsecure/syn-guac/master/guacamole/conf/server.xml"

# Get the nginx site configuration file.
wget -nv -O ./nginx/conf.d/default.conf "https://raw.githubusercontent.com/trustsecure/syn-guac/master/nginx/conf.d/default.conf"
# Get the nginx static page file.
wget -nv -O ./nginx/static/index.html "https://raw.githubusercontent.com/trustsecure/syn-guac/master/nginx/static/index.html"
# Get the docker-compose file for the stack.
wget -nv "https://raw.githubusercontent.com/trustsecure/syn-guac/master/docker-compose.yml"

# Get the reset.sh script, and mark as executable.
wget -nv -O ./scripts/reset.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/scripts/reset.sh"
chmod +x ./scripts/reset.sh
# Get the compose-up.sh script, and mark as executable.
wget -nv -O ./scripts/compose-up.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/scripts/compose-up.sh"
chmod +x ./scripts/compose-up.sh
echo "done"

echo "Creating database initialisation data..."
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./database/init/initdb.sql
echo "done"

echo "Copying DEFAULT syno-ca-cert.pem for import to container(s)..."
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
