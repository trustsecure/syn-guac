# syn-guac
A configuration to run Apache Guacamole on a Synology DiskStation (tested on DS918+)
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
- The Directory certificate needs to be selected as the default in the DiskStation UI.
- others - tbc.

## Quick start - Synology DiskStation
Download the `prepare.sh` script from the repository and run it:
~~~sh
mkdir ./syn-guac
cd syn-guac
wget "https://raw.githubusercontent.com/trustsecure/syn-guac/master/prepare.sh"
chmod +x ./prepare.sh
sudo ./prepare.sh 
~~~

The `prepare.sh` script will create a folder structure and download files from the GitHub repository.

Implementation specific adjustments, like the DNS FQDN and email address for certificate issuing,
domain name and suffix etc. should be made to the `compose-up.sh` script - when done run it:
~~~sh
sudo ./compose-up.sh
~~~


