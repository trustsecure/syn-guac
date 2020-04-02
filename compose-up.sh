#!/bin/sh

# This file contains implementation specific settings and should be adjusted
# prior to being run. At the very minimum the certificate request info and the 
# organisation name value should be edited to provide some uniqueness to the
# installation.


# The email address submitted to Lets Encrypt when obtaining a certificate.
export CERTBOT_EMAIL="support@example.co.uk"

# The external FQDN (subject name) submitted to Lets Encrypt when obtaining a certificate.
# For this to work, external DNS needs to be set up to point to the network's router's public IP
# which is, in turn, port forwarding 80/tcp and 443/tcp to the DiskStation.
export CERTBOT_FQDN="remote.example.co.uk"

# Server and Samba AD Domain details.
export DISKSTATION_NAME=diskstation
export ORG_DOMAIN_NAME=example
export ORG_DOMAIN_SUFFIX=local

# Database password.
export DB_PASSWORD="ChooseYourOwnPasswordHere1234"

# LDAP Bind DN password for ldap_user account.
export LDAP_SEARCH_BIND_PASSWORD="ChooseAnotherPasswordHere5678"

# Bring up the stack.
docker-compose up -d