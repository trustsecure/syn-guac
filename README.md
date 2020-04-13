# syn-guac
A configuration to run Apache Guacamole on a Synology DiskStation (tested on DS918+)
using the Docker package and utilising nginx-certbot as a reverse proxy that handles ssl certificates
and a postgres db backend, and also ldaps authrntication against the Synology's Samba-based Active Directory Server.

## Sources
- https://github.com/boschkundendienst/guacamole-docker-compose
	Example of a functional Guacamole environment running in Docker containers.
- https://github.com/staticfloat/docker-nginx-certbot
	Docker image that integrates certbot functionality in to the nginx server.


## Diskstation Prerequisites
- **Synology Directory Server Package** (Samba Active Directory) installed and configured.
- The Directory Server self-issued certificate needs to be **selected as the default** in the DiskStation Certificates page.
- **Docker Package** installed.
- **SSH Access Enabled**
- others - tbc.

## Quick start - Synology DiskStation
SSH in to the DiskStation and download the `prepare.sh` script from the repository and run it:
~~~sh
mkdir ./guac
cd guac
mkdir ./scripts
wget -nv -O ./scripts/prepare.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/prepare.sh"
chmod +x ./scripts/prepare.sh
sudo ./scripts/prepare.sh 
~~~

The `prepare.sh` script will create a folder structure and download files from the GitHub repository.

Modify the `.env` file to make implementation specific adjustments, the DNS FQDN and email address for certificate issuing,
domain name and suffix etc.  when done run it:

Bring up the stack:
~~~sh
sudo docker-compose up -d
~~~

To stop the stack:
~~~sh
sudo docker-compose down
~~~





