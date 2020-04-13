#!/bin/sh
# Imports the syno-ca-cert.pem CA certificate in to the Java Keystore to allow Guacamole to perform ldaps lookups to Samba AD.
keytool -keystore /etc/ssl/certs/java/cacerts -importcert -file /cert-import/syno-ca-cert.pem -noprompt -storepass changeit -alias diskstation-ad-ca

# Call Startup.
/opt/guacamole/bin/start.sh