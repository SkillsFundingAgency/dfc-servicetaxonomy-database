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
docker run -p7474:7474 -p7687:7687 -v $HOME\neo4j\import:/var/lib/neo4j/import ncs.servicetaxonomy.escodb
```

Browse to http://localhost:7474/browser/ and logon with username: neo4j and password: escodb

Note: if you have previously ran a neo4j docker container, mounted the data folder as an external volume and are reusing that volume then you may need to delete the contents of the mounted folder or mount to a different folder

From the web interface of neo4j run match (n:ns1__Occupation) return n to confirm that the rdf file has loaded (the import process takes about 5 minutes)

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