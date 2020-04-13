# syn-guac
A configuration to run Apache Guacamole on a Synology DiskStation (tested on DS918+) using the `Docker` package 
and ldap/ssl authentication against the `Synology Directory Server` package (Samba based Active Directory).
Utilises `nginx-certbot` as a reverse proxy that automates ssl certificate issuance and a `Postgres` db backend
for Guacamole data.

## DiskStation Prerequisites
- **Synology Directory Server Package** (Samba Active Directory) installed and configured.
- The Directory Server self-issued certificate needs to be **selected as the default** in the DiskStation Certificates page.
- **Docker Package** installed.
- **SSH Access** Enabled.
- others - tbc.

## Quick start - Synology DiskStation
The `prepare.sh` script will create a folder structure and download files from the GitHub repository.
SSH in to the DiskStation, download the `prepare.sh` script from the repository, and run it using the following:
~~~sh
mkdir ./guac
cd guac
mkdir ./scripts
wget -nv -O ./scripts/prepare.sh "https://raw.githubusercontent.com/trustsecure/syn-guac/master/scripts/prepare.sh"
chmod +x ./scripts/prepare.sh
sudo ./scripts/prepare.sh

~~~

Modify the `.env` file to make implementation specific adjustments such as the DNS FQDN and email address for 
certificate issuance, domain name and suffix etc. 

To **Bring up the stack**:
~~~sh
sudo docker-compose up -d
~~~

To **destroy the stack**:
~~~sh
sudo docker-compose down
~~~

## Sources
- https://github.com/boschkundendienst/guacamole-docker-compose
	Example of a functional Guacamole environment running in Docker containers.
- https://github.com/staticfloat/docker-nginx-certbot
	Docker image that integrates certbot functionality in to the nginx server.
