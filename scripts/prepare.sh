#!/bin/sh
# This script is intended to be run on a Synology DiskStation. Tested on DS918+
export BRANCH=master
export REPO_URI="https://raw.githubusercontent.com/trustsecure/syn-guac"
export REPO_STUB="${REPO_URI}/${BRANCH}"
echo "Preparing directory structure..."
mkdir ./scripts >/dev/null 2>&1
mkdir ./guac >/dev/null 2>&1
mkdir ./guac/cert-import >/dev/null 2>&1
mkdir ./guac/database >/dev/null 2>&1
mkdir ./guac/database/data >/dev/null 2>&1
mkdir ./guac/database/init >/dev/null 2>&1
chmod -R +x ./guac/database/init
mkdir ./guac/guacamole >/dev/null 2>&1
mkdir ./guac/guacamole/conf >/dev/null 2>&1
mkdir ./guac/guacamole/entrypoint >/dev/null 2>&1
mkdir ./guac/guacamole/drive >/dev/null 2>&1
mkdir ./guac/guacamole/record >/dev/null 2>&1
mkdir ./proxy >/dev/null 2>&1
mkdir ./proxy/nginx >/dev/null 2>&1
mkdir ./proxy/nginx/conf.d >/dev/null 2>&1
mkdir ./proxy/nginx/static >/dev/null 2>&1
echo "done"
echo "Downloading files.."
wget -nv -O ./scripts/reset.sh "${REPO_STUB}/scripts/reset.sh"
wget -nv -O ./scripts/compose-up-guac.sh "${REPO_STUB}/scripts/compose-up-guac.sh"
wget -nv -O ./scripts/compose-up-proxy.sh "${REPO_STUB}/scripts/compose-up-proxy.sh"
wget -nv -O ./scripts/csyn-guac.conf "${REPO_STUB}/scripts/syn-guac.conf"
wget -nv -O ./guac/docker-compose.yml "${REPO_STUB}/guac/docker-compose.yml"
wget -nv -O ./guac/guacamole/conf/server.xml "${REPO_STUB}/guac/guacamole/conf/server.xml"
wget -nv -O ./guac/guacamole/entrypoint/certimport-entrypoint.sh "${REPO_STUB}/guac/guacamole/entrypoint/certimport-entrypoint.sh"
wget -nv -O ./proxy/docker-compose.yml "${REPO_STUB}/proxy/docker-compose.yml"
wget -nv -O ./proxy/nginx/conf.d/default.conf "${REPO_STUB}/proxy/nginx/conf.d/default.conf"
wget -nv -O ./proxy/nginx/static/index.html "${REPO_STUB}/proxy/nginx/static/index.html"
chmod +x ./guac/guacamole/entrypoint/certimport-entrypoint.sh
chmod +x ./scripts/reset.sh
chmod +x ./scripts/compose-up-guac.sh
chmod +x ./scripts/compose-up-proxy.sh
echo "done"
echo "Creating database initialisation data..."
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./guac/database/init/initdb.sql
echo "done"
echo "Copying DEFAULT syno-ca-cert.pem for import to container(s)..."
# Grab DiskStation's default certificate (make sure the AD SSL self-cert is set as the default!)
for i in `cat /usr/syno/etc/certificate/_archive/DEFAULT` ; do cp -f /usr/syno/etc/certificate/_archive/$i/syno-ca-cert.pem ./guac/cert-import/ ; done
echo "done"
echo "************************************************************************"
echo " prepare.sh finished - check for errors above!"
echo "************************************************************************"
echo " You should customise the compose-up.sh file with organisation specific"
echo " passwords and other settings, then run it:"
echo " i.e."
echo " $ sudo ./compose-up.sh"
echo "************************************************************************"
