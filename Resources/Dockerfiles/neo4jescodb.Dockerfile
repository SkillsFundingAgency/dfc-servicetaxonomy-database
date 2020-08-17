#End of Line (eol) setting needs to be overriden in .gitattributes, if it isn't the image will fail to run if built on a Windows machine

#APOC plugin version must track the major.minor version of neo4j so the base image for this dockerfile is specified rather than using latest
#https://github.com/neo4j-contrib/neo4j-apoc-procedures#version-compatibility-matrix
FROM neo4j:4.0.4

#the esco file must be provisioned in a folder that is mounted to /var/lib/neo4j/import/
ENV ESCOFILE esco_v1.0.3.ttl
ENV NEO4J_PWD escodb
ENV NEO4J_AUTH neo4j/$NEO4J_PWD
ENV NEO4J_dbms_allow__upgrade=true
ENV NEO4J_dbms_recovery_fail__on__missing__files=false
ENV NEO4J_dbms_memory_pagecache_size=5600M
ENV NEO4J_dbms_connector_bolt_address=0.0.0.0:7687
ENV NEO4J_dbms_connector_bolt_enabled=true
ENV NEO4J_dbms_connector_bolt_tls__level=OPTIONAL
ENV NEO4J_dbms_connector_bolt_listen__address=0.0.0.0:7687
ENV NEO4J_dbms_connector_https_enabled=true
ENV NEO4J_dbms_connector_https_listen__address=0.0.0.0:7473
ENV NEO4J_dbms_security_auth__enabled=false
#ENV NEO4J_dbms_default__database=graph
ENV NEO4J_dbms_ssl_policy_bolt_enabled=true
ENV NEO4J_dbms_ssl_policy_https_enabled=true
ENV NEO4J_dbms_security_procedures_whitelist=apoc.coll.*,apoc.load.*,apoc.*,n10s.*,ncs.*
ENV NEO4J_dbms_security_procedures_unrestricted=apoc.*,n10s.*,ncs.*
ENV NEO4J_dbms_wrapper_java__additional=-Dneo4j.ext.udc.source=docker
ENV NEO4J_dbms__jvm__additional=-Dunsupported.dbms.udc.source=docker
ENV NEO4J_unsupported_dbms_tx__log_fail__on__corrupted__log__files=false

# Install dependencies for Azure DevOps agent
RUN apt-get update 
# Required to install libicu55 on Ubuntu versions > 16.04, the base image of owasp/zap2docker-stable at the time of writing is later than 16.04
#RUN apt-get install software-properties-common
#RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    jq \
    git \
    iputils-ping \
    libcurl4 \
    libunwind8 \
    netcat
# curl install returns broken package error if installed alongside other packages
RUN apt-get install --no-install-recommends curl
# Finished installing dependencies for Azure DevOps agent

# install PowerShell
RUN apt-get install wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN add-apt-repository universe
RUN apt-get install -y powershell

WORKDIR /azp
COPY AgentScripts/install-agent.sh .
RUN chmod +x install-agent.sh

WORKDIR /supervisor
COPY Supervisor/supervisord.conf .
RUN chmod +x supervisord.conf

#add scripts and plugins
COPY --chown=neo4j:neo4j Neo4jScripts /scripts
RUN chmod -R 754 /scripts
#copy jar file compiled from editor into the Dockerfile plugins folder
COPY --chown=neo4j:neo4j plugins /var/lib/neo4j/plugins
#download jar files into plugins folder
ADD --chown=neo4j:neo4j https://github.com/neo4j-labs/neosemantics/releases/download/4.0.0.1/neosemantics-4.0.0.1.jar plugins
ADD --chown=neo4j:neo4j https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/4.0.0.12/apoc-4.0.0.12-all.jar plugins
ENTRYPOINT ["/scripts/wrapper.sh"]