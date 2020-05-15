#End of Line (eol) setting needs to be overriden in .gitattributes, if it isn't the image will fail to run if built on a Windows machine

#APOC plugin version must track the major.minor version of neo4j so the base image for this dockerfile is specified rather than using latest
#https://github.com/neo4j-contrib/neo4j-apoc-procedures#version-compatibility-matrix
FROM neo4j:4.0.4

#the esco file must be provisioned in a folder that is mounted to /var/lib/neo4j/import/
ENV ESCOFILE esco_v1.0.3.ttl
ENV NEO4J_PWD escodb
ENV NEO4J_AUTH neo4j/$NEO4J_PWD
ENV NEO4J_dbms_memory_pagecache_size=5600M
ENV NEO4J_dbms_connector_https_enabled=true
ENV NEO4J_dbms_allow__upgrade=false
ENV NEO4J_dbms_default__database=graph
ENV NEO4J_dbms_ssl_policy_https_enabled=true
ENV NEO4J_dbms_ssl_policy_bolt_enabled=true
ENV NEO4J_dbms_security_procedures_whitelist=apoc.coll.*,apoc.load.*,apoc.*,n10s.*
ENV NEO4J_dbms_security_procedures_unrestricted=apoc.*,n10s.*
#add scripts and plugins
COPY --chown=neo4j:neo4j Neo4jScripts /scripts
RUN chmod -R 754 /scripts
#copy jar file compiled from editor into the Dockerfile plugins folder
#COPY --chown=neo4j:neo4j plugins /var/lib/neo4j/plugins
#download jar files into plugins folder
#ADD --chown=neo4j:neo4j https://github.com/neo4j-labs/neosemantics/releases/download/4.0.0.1/neosemantics-4.0.0.1.jar plugins
#ADD --chown=neo4j:neo4j https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/4.0.0.11/apoc-4.0.0.11-all.jar plugins
ENTRYPOINT ["/scripts/wrapper.sh"]