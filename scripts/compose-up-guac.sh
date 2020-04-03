#!/bin/sh
# This file contains implementation specific settings and should be adjusted prior to being run.

export APP_DIRECTORY=/volume1/docker/syn-guac
export CONFIG_FILE=syn-guac.conf
export COMPONENT=guac

# Read in configuration settings as variables and export them to the environment.
export $(grep --regexp ^[A-Z] ${APP_DIRECTORY}/${CONFIG_FILE} | cut -d= -f1)

# Bring up the stack.
docker-compose up -d -f ${APP_DIRECTORY}/${COMPONENT}/docker-compose.ym
