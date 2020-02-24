# dfc-servicetaxonomy-database

Contains the files necessary to build and configure the Neo4J database container used by the DFC Service Taxonomy project.  The container is build with neosemantics & apoc plugins installed.  On startup it imports the esco rdf file (this needs to be provisioned separately in a mounted volume).

## How to use - Docker

From the root of this repo you can build the image locally

```
cd Resources\Dockerfiles
docker build -t ncs.servicetaxonomy.escodb --file neo4jescodb.Dockerfile .
```

Or you can pull the image from the dfcdevsharedcr repository

Install the az command line tools

```
az login
az acr login --name dfcdevsharedcr
docker pull dfcdevsharedcr.azurecr.io/ncs.servicetaxonomy.escodb:<tag>
```

On a Windows host:

Open a PowerShell prompt

```PowerShell
New-Item $HOME\neo4j\import -ItemType Directory
```

Download and copy the esco rdf file to $HOME\neo4j\import

```
docker run -p7474:7474 -p7687:7687 -e NEO4J_dbms_memory_pagecache_size=500M -v $HOME\neo4j\import:/var/lib/neo4j/import ncs.servicetaxonomy.escodb
```

Browse to http://localhost:7474/browser/ and logon with username: neo4j and password: escodb

Note: if you have previously ran a neo4j docker container, mounted the data folder as an external volume and are reusing that volume then you may need to delete the contents of the mounted folder or mount to a different folder

From the web interface of neo4j run `match (n:esco__Occupation) return n` to confirm that the rdf file has loaded (the import process takes about 5 minutes)

## How to use - Kubernetes

The neo4jescodb.yaml contains the manifest for deploying a single instance of the image into a Kubernetes cluster.  Instructions for setting up the cluster can be found in Jira ticket NCSD-2037

### Connecting to the Kubernetes cluster

Assuming you've installed the az cli (instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)) and kubectl ( after installing az cli `az aks install-cli`) connect to the DEV cluster with the following commands:

```
az login
az account set --subscription SFA-CDH-Dev/Test
az aks get-credentials --resource-group dfc-dev-shared-rg --name dfc-dev-shared-aks --admin
```

and test that you've connected successfully by running `kubectl get nodes`

#### Decoding the secret stored in Kubernetes

```
kubectl get secret neo4j-account-secret -o yaml
```
This will return:
```
apiVersion: v1
data:
  auth: <an-encoded-string>
  password: <an-encoded-string>
  username: <an-encoded-string>
kind: Secret
metadata:
  creationTimestamp: "<a-date>"
  name: neo4j-account-secret
  namespace: default
  resourceVersion: "1234567"
  selfLink: /api/v1/namespaces/default/secrets/neo4j-account-secret
  uid: <a-guid>
```

In a PS prompt copy and paste one of the \<an-encoded-string> into ```[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("<an-encoded-string>"))```

## Notes on SSL configuration

This [document](https://neo4j.com/docs/operations-manual/3.5/security/ssl-framework/) explains the settings needed to set up SSL\TLS connections in version 3.5, changes may be required when upgrading to version 4 of neo4j as additional settings have been implemented.

As well as configuring SSL policy there are also seperate settings to enable the HTTPS connector.  These do not need to be configured in the current version of the neo4j container, it works out of the box but for reference the settings for version 3.5 are found [here](https://neo4j.com/docs/operations-manual/3.5/configuration/connectors/)

The neo4j container runs on Linux so the certificate files need to be in the pem format.  Several scripts execute as part of the pipeline to convert the certificate stored in Azure KeyVault to the pem format that neo4j can consume.  As a useful reference this [article](https://medium.com/neo4j/getting-certificates-for-neo4j-with-letsencrypt-a8d05c415bbd) explains how to set up neo4j with LetsEncrypt which natively produces certificates in the correct format.  The article states that the fullchain.pem file needs to be copied to the certificate base directory, in this implementation that caused errors related to the certificate chain when browsing to the web frontend.  Instead a cert.pem file was created that just contains the client certificate without any of the chain.