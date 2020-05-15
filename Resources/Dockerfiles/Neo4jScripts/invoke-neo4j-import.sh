cp -R -v /var/certificates /var/lib/neo4j/ >> copyresult.log

chown -R -v neo4j:neo4j /var/lib/neo4j/certificates/* >> chown.log

sed -i "s/__ESCOFILE__/$ESCOFILE/g" /scripts/neo4j-import

until cat /scripts/neo4j-db-config | /var/lib/neo4j/bin/cypher-shell --format plain  -u neo4j -p $NEO4J_PWD
do
    echo "db config failed, sleeping"
    sleep 10
done

until cat /scripts/neo4j-import | /var/lib/neo4j/bin/cypher-shell --format plain -u neo4j -p $NEO4J_PWD 
do
    echo "import failed, sleeping"
    sleep 10
done

until cat /scripts/neo4j-rename-esco-occupation-hidden-label-to-alt-label | /var/lib/neo4j/bin/cypher-shell --format plain -u neo4j -p $NEO4J_PWD 
do
    echo "import failed, sleeping"
    sleep 10
done
