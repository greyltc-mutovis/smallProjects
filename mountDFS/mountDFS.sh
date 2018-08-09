#!/usr/bin/env bash

# mounts the physics DFS folder, use with sudo, will prompt for

echo Enter your physics username:

read PHYSICS_USER

THIS_USER=`pstree -lu -s $$ | grep --max-count=1 -o '([^)]*)' | head -n 1 | sed 's/[()]//g'`

mkdir -p /mnt/dfs
mount -t cifs //physics.ox.ac.uk/dfs /mnt/dfs -o user=${PHYSICS_USER},dom=PHYSICS,vers=2.1,uid=`id -u ${THIS_USER}`

