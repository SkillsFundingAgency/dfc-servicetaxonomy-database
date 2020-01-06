<#
.SYNOPSIS
Orchestrates a jMeter tests against the dfc-servicetaxonomy-database.

.DESCRIPTION
Orchestrates a jMeter tests against the dfc-servicetaxonomy-database.  Runs the test for a specified number of iterations and aggregates the output.

.PARAMETER JMeterBinDir
The path to the bin directory of the jMeter Java application.  On the dfc-devops jMeter-agent container this is /opt/apache-jmeter-5.2.1/bin (version number correct at time of writing)

.PARAMETER ServerName
The hostname of the Neo4j server to run the test against

.PARAMETER BoltRetries
The number of times to re-try if a Bolt error is encountered. Default value is 2

.PARAMETER BoltConnectionTimeout
The maximum time in seconds to wait for a request made over a Bolt connection. Default value is 60 seconds

.PARAMETER Duration
The run time of each test iteration in seconds. Default value is 120 seconds

.PARAMETER HitRate
Specifying a HitRate will override iteration settings and result in a constant load test which runs for the supplied Duration. Default value is 25

.PARAMETER Iterations
The number of cycles that will be executed. The hit rate will be incremented after each iteration using a Fibonacci sequence. Default value 1

.PARAMETER JmxTestFileName
Specify the location of the JMeter test project. Default value /tests/NeoLoadTest.jmx

.PARAMETER NumberOfThreads
The number of concurrent processes that JMeter will employ to create requests. Default value 5

.PARAMETER NumberOfConnections
The number of Bolt instances that will be created during the load test.  Default value 1 (as per recommendations in Neo4j Developer documenation)

.PARAMETER OutputFolder
Specify the location for test output. Default value "/tests/test001"

.PARAMETER Protocol
The protocol to be employed during the test. Accepted values http|bolt. Default value is "bolt"

.PARAMETER Seed1
Specify the first increment after the intial iteration has completed. Default value 1

.PARAMETER Seed2
Specify the initial hit rate. Default value 1

.PARAMETER SingleLabel
If specified, all request labels will be based on the current hit rate rather than the request description. Default value "N"

. EXAMPLE
. ./Invoke-Neo4jLoadTest.ps1 -ServerName dfc-dev-stax-database.westeurope.cloudapp.azure.com -JMeterBinDir "/opt/apache-jmeter-5.2.1/bin"
#>
[CmdletBinding()]
param
(
	[Parameter(Mandatory=$true)]
	[string]$JMeterBinDir,
	[Parameter(Mandatory=$true)]
	[string]$ServerName,
	[Parameter(Mandatory=$false)]
	[int]$BoltRetries = 2,
	[Parameter(Mandatory=$false)]
	[int]$BoltConnectionTimeout = 60,
	[Parameter(Mandatory=$false)]
	[int]$Duration = 120,
	[Parameter(Mandatory=$false)]
	[int]$HitRate = 25,
	[Parameter(Mandatory=$false)]
	[int]$Iterations = 1,
	[Parameter(Mandatory=$false)]
	[string]$JmxTestFilePath = "/tests/NeoLoadTest.jmx",
	[Parameter(Mandatory=$false)]
	[int]$NumberOfThreads = 5,
	[Parameter(Mandatory=$false)]
	[int]$NumberOfConnections = 1,
	[Parameter(Mandatory=$false)]
	[string]$OutputFolder = "/tests/test001",
	[Parameter(Mandatory=$false)]
	[string]$Protocol = "bolt",
	[Parameter(Mandatory=$false)]
	[int]$Seed1 = 1,
	[Parameter(Mandatory=$false)]
	[int]$Seed2 = 1,
	[Parameter(Mandatory=$false)]
	[string]$SingleLabel = "N"
)

Write-Output "Protocol: $Protocol"
Write-Output "ServerName: $ServerName"
Write-Output "Durations: $Duration"
Write-Output "NumberOfThreads: $NumberOfThreads"
Write-Output "iterations: $interations"
Write-Output "Single Label: $SingleLabel"
Write-Output "hitRate override: $HitRate"
Write-Output "number of connections: $NumberOfConnections"
Write-Output "JmxTestFilePath: $JmxTestFilePath"

#exit;
function Out-FileUtf8NoBom {

	[CmdletBinding()]
	param(
		[Parameter(Mandatory, Position = 0)] [string] $LiteralPath,
		[switch] $Append,
		[switch] $NoClobber,
		[AllowNull()] [int] $Width,
		[Parameter(ValueFromPipeline)] $InputObject
	)

	#requires -version 3

	# Make sure that the .NET framework sees the same working dir. as PS and resolve the input path to a full path.
	[System.IO.Directory]::SetCurrentDirectory($PWD) # Caveat: .NET Core doesn't support [Environment]::CurrentDirectory
	$LiteralPath = [IO.Path]::GetFullPath($LiteralPath)

	# If -NoClobber was specified, throw an exception if the target file already exists.
	if ($NoClobber -and (Test-Path $LiteralPath)) {

		throw [IO.IOException] "The file '$LiteralPath' already exists."

	}

	# Create a StreamWriter object.  Note that we take advantage of the fact that the StreamWriter class by default:
	# - uses UTF-8 encoding
	# - without a BOM.
	$StreamWriter = New-Object IO.StreamWriter $LiteralPath, $Append

	$HtOutStringArgs = @{}
	if ($Width) {

		$HtOutStringArgs += @{ Width = $Width }

	}

	# Note: By not using begin / process / end blocks, we're effectively running
	#       in the end block, which means that all pipeline input has already
	#       been collected in automatic variable $Input.
	#       We must use this approach, because using | Out-String individually
	#       in each iteration of a process block would format each input object
	#       with an indvidual header.
	try {

		$Input | Out-String -Stream @HtOutStringArgs | ForEach-Object { $StreamWriter.WriteLine($_) }

	}
	finally {

		$StreamWriter.Dispose()

	}

}
    
$NumberOfThreads = 50

if ($Protocol -eq "http") {

	$NumberOfThreads = 100

}

# set paths
$OutFilename = $OutputFolder + "/neo_request_output.csv"

Write-Output "output_dir: $OutputFolder"

# set output filenames
$OverallResultsSummary = "neo_results_full.csv"
$OverallAggSummary = "neo_aggregation_full.csv"

# intialise load params
$PreviousTargetHitRate = $Seed1
$CurrentTargetHitRate = $Seed2

if ($HitRate -gt 0) {

	Write-Output "Setting up for a single interation at hit rate of $HitRate"
	$CurrentTargetHitRate = $HitRate
	$Iterations = 1

}

$LoopCount = 0
# begin loop
while ($LoopCount -lt $Iterations) {

	$LoopCount += 1

	# run test
	Write-Output "Running jMeter  Test: $JmxTestFilePath Server: $ServerName Protocol: $Protocol TargerRate: $CurrentTargetHitRate ..."
	Invoke-Expression -Command "jmeter -n -t $JmxTestFilePath -J HostName=$ServerName -J Protocol=$Protocol -J TargetRate=$CurrentTargetHitRate -J NumberOfThreads=$NumberOfThreads -J Duration=$Duration -j $OutputFolder/logfile$LoopCount.log -J SingleLabel=$SingleLabel -J ResultsFile=$OutFilename -J NumberOfConnections=$NumberOfConnections -J BoltRetries=$BoltRetries -J BoltConnectionTimeout=$BoltConnectionTimeout"

	# generate aggregation report
	Write-Output "Generating aggregation report ..."
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-csv $OutputFolder/Aggregate_Report_$CurrentTargetHitRate.csv --input-jtl $OutFilename --plugin-type AggregateReport"

	# generate graphs??
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputFolder/hits_per_second_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type HitsPerSecond --width 800 --height 400 --granulation 10000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputFolder/ResponseTimesOverTime_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type ResponseTimesOverTime --width 800 --height 400 --granulation 10000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputFolder/TransactionsPerSecond_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type TransactionsPerSecond --width 800 --height 400 --granulation 10000"

    
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputFolder/hits_per_second_a_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type HitsPerSecond --width 800 --height 600 --granulation 20000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputFolder/ResponseTimesOverTime_a_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type ResponseTimesOverTime --width 600 --height 400 --granulation 20000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputFolder/TransactionsPerSecond_a_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type TransactionsPerSecond --width 600 --height 400 --granulation 20000"
	#cmd.exe /v $JMeterBinDir\$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png "F:\Jmeter\output\ResponseTimesOverTime_TEST.png" --input-jtl "F:\Jmeter\output\http_request_output.csv" --plugin-type ResponseTimesOverTime
	
	# add to / initialise overarching results file
	$Output = get-content $OutFilename 
	if ($LoopCount -eq 1) {

		#initalise overarching file
		$Output | Select-Object -first 1 | ForEach-Object { $_ } | Out-FileUtf8NoBom  $OutputFolder/$OverallResultsSummary 

	}
	$Output | Select-Object -skip 1 | ForEach-Object { $_ } | Out-FileUtf8NoBom -Append $OutputFolder/$OverallResultsSummary

	#add to / initialise overaching aggregation report
	$Output2 = get-content $OutputFolder/Aggregate_Report_$CurrentTargetHitRate.csv
	if ($LoopCount -eq 1) {

		#initalise overarching file
		Write-Output "Protocol,Target Workload,Request,# Samples,Average,Median,90% Line,95% Line,99% Line,Minimum,Maximum,Error %,Throughput,Bandwith,Stddev" | Out-FileUtf8NoBom  $OutputFolder/$OverallAggSummary

	}
	$Output2 | Select-Object -skip 1 | ForEach-Object { $Protocol + "," + $CurrentTargetHitRate + "," + $_ } | Out-FileUtf8NoBom -Append $OutputFolder/$OverallAggSummary

	# add to overarching aggregration report
	# https://stackoverflow.com/questions/9813228/add-rows-to-csv-file-in-powershell

	# increment load params
	$newTargetHitRate = $PreviousTargetHitRate + $CurrentTargetHitRate
	$PreviousTargetHitRate = $CurrentTargetHitRate
	$CurrentTargetHitRate = $newTargetHitRate

}
# end loop

# generate overarching test report
Remove-Item  -Recurse $OutputFolder/report -ErrorAction SilentlyContinue

Invoke-Expression -Command "jmeter -g $OutputFolder/$OverallResultsSummary -o $OutputFolder/report"
