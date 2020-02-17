<#
.SYNOPSIS
Create the directory structure required by neo4j for storing TLS certificates.

.DESCRIPTION
Create the directory structure required by neo4j for storing TLS certificates.

.PARAMETER ResourceGroupName
The name of Resource Group that contains the FileShare.

.PARAMETER ShareName
The name of the FileShare that the directories will be created in.

.PARAMETER StorageAccountName
The name of the Storage Account that contains the FileShare.

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [String]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [String]$ShareName,
    [Parameter(Mandatory=$true)]
    [String]$StorageAccountName
)

function Set-AzStorageDirectory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Microsoft.WindowsAzure.Commands.Storage.AzureStorageContext]$Context,
        [Parameter(Mandatory=$true)]
        [String]$Path,
        [Parameter(Mandatory=$true)]
        [String]$ShareName
    )

    if (!(Get-AzStorageFile -ShareName $ShareName -Path $Path -Context $Context -ErrorAction SilentlyContinue)) {

        Write-Verbose "Creating directory $Path in file share $ShareName"
        New-AzStorageDirectory -ShareName $ShareName -Path $Path -Context $Context
        
    }

    else {
        
        Write-Verbose "No action, $Path already exists"

    }
}

# Fetch storage account key via Az module
Write-Verbose "Fetching storage account keys"
$StorageAccountKeys = Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -ErrorAction SilentlyContinue

if(!$StorageAccountKeys) {

    throw "Unable to fetch account keys from storage account '$($StorageAccountName)'"

}
$AccountKey = ($StorageAccountKeys | Where-Object { $_.keyName -eq "key1" }).Value

Write-Verbose "Creating storage context"
$Context = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $AccountKey

Set-AzStorageDirectory -ShareName $ShareName -Path "default" -Context $Context
Set-AzStorageDirectory -ShareName $ShareName -Path "default\trusted" -Context $Context
Set-AzStorageDirectory -ShareName $ShareName -Path "default\revoked" -Context $Context