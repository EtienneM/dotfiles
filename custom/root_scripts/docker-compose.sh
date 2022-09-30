#!/bin/bash

version=v2.10.2
docker_config=/usr/local/lib/docker

sudo mkdir -p "${docker_config}/cli-plugins"

sudo curl -SL https://github.com/docker/compose/releases/download/${version}/docker-compose-linux-x86_64 -o $docker_config/cli-plugins/docker-compose
failFast $? "Fail to download docker-compose"

sudo chmod +x "${docker_config}/cli-plugins/docker-compose"
failFast $? "Fail to update docker-compose rights"
