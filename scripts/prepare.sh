#!/bin/sh
# This script is intended to be run on a Synology DiskStation. Tested on DS918+
export BRANCH=master
export REPO_URI="https://raw.githubusercontent.com/trustsecure/syn-guac"
export REPO_STUB="${REPO_URI}/${BRANCH}"
echo "Preparing directory structure..."
mkdir ./scripts >/dev/null 2>&1
mkdir ./cert-import >/dev/null 2>&1
mkdir ./database >/dev/null 2>&1
mkdir ./database/data >/dev/null 2>&1
mkdir ./database/init >/dev/null 2>&1
chmod -R +x ./database/init
mkdir ./guacamole >/dev/null 2>&1
mkdir ./guacamole/conf >/dev/null 2>&1
mkdir ./guacamole/drive >/dev/null 2>&1
mkdir ./guacamole/record >/dev/null 2>&1
mkdir ./nginx >/dev/null 2>&1
mkdir ./nginx/conf >/dev/null 2>&1
mkdir ./nginx/static >/dev/null 2>&1
echo "done"
echo "Downloading files.."
wget -nv -O ./scripts/reset.sh "${REPO_STUB}/scripts/reset.sh"
wget -nv -O ./scripts/certimport-entrypoint.sh "${REPO_STUB}/scripts/certimport-entrypoint.sh"
wget -nv -O ./docker-compose.yml "${REPO_STUB}/docker-compose.yml"
wget -nv -O ./.env "${REPO_STUB}/.env"
wget -nv -O ./guacamole/conf/server.xml "${REPO_STUB}/guacamole/conf/server.xml"
#wget -nv -O ./nginx/conf/nginx.conf "${REPO_STUB}/proxy/nginx/conf/nginx.conf"
wget -nv -O ./nginx/conf/certbot.conf "${REPO_STUB}/nginx/conf/certbot.conf"
wget -nv -O ./nginx/conf/default.conf "${REPO_STUB}/nginx/conf/default.conf"
wget -nv -O ./nginx/wwwroot/index.html "${REPO_STUB}/nginx/wwwroot/index.html"
chmod +x ./scripts/reset.sh
chmod +x ./scripts/certimport-entrypoint.sh
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
echo " You should customise the .env files in the guac and proxy directories"
echo " with organisation specific passwords and other settings prior to"
echo " bringing up the stacks."
echo "************************************************************************"
