#!/bin/bash

# Check if .env file exists
if [ -e .env ]; then
    source .env
else
    echo "Error: please ensure your .env file has been configured"
    exit 1
fi

# Create docker network
docker network create nginx-proxy

# Fetch latest nginx.tmpl
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > nginx.tmpl

# Spin up services
docker-compose up
