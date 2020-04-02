# syn-guac

syn-guac: A configuration to run Apache Guacamole on a Synology DiskStation (tested on DS 918+)
using the Docker package and utilising nginx-certbot as a reverse proxy that handles ssl certificates
and a postgres db backend, and also ldaps authrntication against the Synology's Samba-based Active Directory Server.

## Sources
- https://github.com/boschkundendienst/guacamole-docker-compose
	Example of a functional Guacamole environment running in Docker containers.
- https://github.com/staticfloat/docker-nginx-certbot
	Docker image that integrates certbot functionality in to the nginx server.


## Prerequisites
- You need a working **docker** installation and **docker-compose** running on your machine.
- Synology Directory Server (Samba Active Directory) package needs to be installed and configured.
- others - tbc.

## Quick start - Synology DiskStation
Download the prepare.sh script from the repository and run it.
~~~sh
mkdir ./syn-guac
cd syn-guac
wget -O ./prepare.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/prepare.sh"
chmod +x ./prepare.sh
./prepare.sh 
docker-compose up -d
~~~
