#End of Line (eol) setting needs to be overriden in .gitattributes, if it isn't the image will fail to run if built on a Windows machine

#APOC plugin version must track the major.minor version of neo4j so the base image for this dockerfile is specified rather than using latest
#https://github.com/neo4j-contrib/neo4j-apoc-procedures#version-compatibility-matrix
FROM neo4j:3.5

#the esco file must be provisioned in a folder that is mounted to /var/lib/neo4j/import/
ENV ESCOFILE esco_v1.0.3.ttl
ENV NEO4J_PWD escodb
ENV NEO4J_AUTH neo4j/$NEO4J_PWD
ENV NEO4J_dbms_memory_pagecache_size=5600M
##tls config
ENV NEO4J_dbms_connectors_default__listen__address=0.0.0.0
ENV NEO4J_dbms_connectors_default__advertised__address=dev.servicetaxonomy.nationalcareersservice.org.uk
ENV NEO4J_dbms_connector_https_enabled=true
#ENV NEO4J_dbms_ssl_policy_https_enabled=true #this setting is not required until v4.0
ENV NEO4J_dbms_ssl_policy_default_base__directory=/var/certificates/default
ENV NEO4J_dbms_ssl_policy_default_public__certificate=/var/certificates/default/cert.pem
ENV NEO4J_dbms_ssl_policy_default_private__key=/var/certificates/default/privkey.pem
ENV NEO4J_dbms_ssl_policy_default_trusted__dir=/var/certificates/default/trusted
ENV NEO4J_dbms_ssl_policy_default_revoked__dir=/var/certificates/default/revoked
ENV NEO4J_dbms_ssl_policy_default_client__auth=NONE
ENV NEO4J_https_ssl__policy=default
ENV NEO4J_bolt_ssl__policy=default
#add scripts and plugins
COPY --chown=neo4j:neo4j Neo4jScripts /scripts
RUN chmod -R 754 /scripts
ADD --chown=neo4j:neo4j https://github.com/neo4j-labs/neosemantics/releases/download/3.5.0.3/neosemantics-3.5.0.3.jar plugins
ADD --chown=neo4j:neo4j https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.5/apoc-3.5.0.5-all.jar plugins
ENTRYPOINT ["/scripts/wrapper.sh"]