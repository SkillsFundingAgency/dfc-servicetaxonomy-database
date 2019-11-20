#Line end of line (eol) setting will need to be overriden in .gitattributes, if it isn't the image will fail to run if built on a Windows machine

#APOC plugin version must track the major.minor version of neo4j so the base image for this dockerfile is specified rather than using latest
#https://github.com/neo4j-contrib/neo4j-apoc-procedures#version-compatibility-matrix
FROM neo4j:3.5
#if you have previously ran a neo4j docker container, mounted the data folder as an external volume and are reusing that volume then you may need to delete the contents of the mounted folder or mount to a different folder

#the esco file must be provisioned in a folder that is mounted to /var/lib/neo4j/import/
ENV ESCOFILE esco_v1.0.3.ttl
ENV NEO4J_PWD escodb
ENV NEO4J_AUTH neo4j/$NEO4J_PWD
COPY --chown=neo4j:neo4j Neo4jScripts /scripts
RUN chmod -R 754 /scripts
ADD --chown=neo4j:neo4j https://github.com/neo4j-labs/neosemantics/releases/download/3.5.0.3/neosemantics-3.5.0.3.jar plugins
ADD --chown=neo4j:neo4j https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.5/apoc-3.5.0.5-all.jar plugins
ENTRYPOINT ["/scripts/wrapper.sh"]
#TO DO: fix logger warning at startup