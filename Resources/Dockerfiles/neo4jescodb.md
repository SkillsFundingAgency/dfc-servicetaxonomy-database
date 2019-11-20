# Neo4j Docker Container with EscoDb provisioned

Provisions a neo4j container with neosemantics & apoc plugins installed.  Imports the esco rdf file (this needs to be provisioned in a mounted volume).

## How to use - Docker

From the root of this repo you can build the image locally

cd Resources\Dockerfiles
docker build -t ncs.servicetaxonomy.escodb --file neo4jescodb.Dockerfile .

Or you can pull the image from the dfcdevsharedcr repository

Install the az command line tools
az login
az acr login --name dfcdevsharedcr
docker pull dfcdevsharedcr.azurecr.io/ncs.servicetaxonomy.escodb:<tag>

On a Windows host:

Open a PowerShell prompt

New-Item $HOME\neo4j\import -ItemType Directory

Download and copy the esco rdf file to $HOME\neo4j\import

docker run -p7474:7474 -p7687:7687 -v $HOME\neo4j\import:/var/lib/neo4j/import ncs.servicetaxonomy.escodb

Browse to http://localhost:7474/browser/ and logon with username: neo4j and password: escodb

From the web interface of neo4j run match (n:ns1__Occupation) return n to confirm that the rdf file has loaded (the import process takes about 5 minutes)

## How to use - Kubernetes

The neo4jescodb.yaml contains the manifest for deploying a single instance of the image into a Kubernetes cluster.  Instructions for setting up the cluster can be found in Jira ticket NCSD-2037