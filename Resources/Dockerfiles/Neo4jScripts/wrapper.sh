#!/bin/bash

#https://stackoverflow.com/questions/48357238/how-can-i-run-cypher-scripts-on-startup-of-a-neo4j-docker-container

# turn on bash's job control
set -m

# Start the primary process and put it in the background
/docker-entrypoint.sh neo4j &

# Start the helper process
#/scripts/invoke-neo4j-import.sh

# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns

# now we bring the primary process back into the foreground
# and leave it there
fg %1