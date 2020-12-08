#!/bin/bash

#https://stackoverflow.com/questions/48357238/how-can-i-run-cypher-scripts-on-startup-of-a-neo4j-docker-container

# Log the info with the same format as NEO4J outputs
log_info() {
  # https://www.howtogeek.com/410442/how-to-display-the-date-and-time-in-the-linux-terminal-and-use-it-in-bash-scripts/
  printf '%s %s\n' "$(date -u +"%Y-%m-%d %H:%M:%S:%3N%z") INFO  Wrapper: $1"
  return
}

# turn on bash's job control
set -m

# wait for Neo4j
log_info "Waiting until neo4j stats at :7474 ..."
wget --quiet --tries=10 --waitretry=2 -O /dev/null http://localhost:7474

# Start the primary process and put it in the background
/docker-entrypoint.sh neo4j &

# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns

# now we bring the primary process back into the foreground
# and leave it there
fg %1