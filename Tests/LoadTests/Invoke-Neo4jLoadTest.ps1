<#
. EXAMPLE
. ./Invoke-Neo4jLoadTest.ps1 -ServerName dfc-dev-stax-database.westeurope.cloudapp.azure.com -JMeterBinDir "/opt/apache-jmeter-5.2.1/bin"
#>
[CmdletBinding()]
param
(
	[string]$Protocol = "http",
	[string]$ServerName = "localhost",
	[int]$Duration = 120,
	[int]$NumberOfThreads = 1,
	[int]$NumberOfConnections = 1,
	[int]$Iterations = 1,
	[string]$OutputFolder = "test1",
	[int]$HitRate = 0,
	[string]$SingleLabel = "N",
	[string]$JMeterBinDir = "F:\Jmeter",
	[string]$JmxTestFileName = "NeoLoadTest.jmx",
	[int]$Seed1 = 1,
	[int]$Seed2 = 1,
	[int]$BoltRetries = 2,
	[int]$BoltConnectionTimeout = 60
)


Write-Output "Protocol: $Protocol"
Write-Output "ServerName: $ServerName"
Write-Output "Durations: $Duration"
Write-Output "NumberOfThreads: $NumberOfThreads"
Write-Output "iterations: $interations"
Write-Output "Single Label: $SingleLabel"
Write-Output "hitRate override: $HitRate"
Write-Output "number of connections: $NumberOfConnections"

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

	# Make sure that the .NET framework sees the same working dir. as PS
	# and resolve the input path to a full path.
	[System.IO.Directory]::SetCurrentDirectory($PWD) # Caveat: .NET Core doesn't support [Environment]::CurrentDirectory
	$LiteralPath = [IO.Path]::GetFullPath($LiteralPath)

	# If -NoClobber was specified, throw an exception if the target file already
	# exists.
	if ($NoClobber -and (Test-Path $LiteralPath)) {
		Throw [IO.IOException] "The file '$LiteralPath' already exists."
	}

	# Create a StreamWriter object.
	# Note that we take advantage of the fact that the StreamWriter class by default:
	# - uses UTF-8 encoding
	# - without a BOM.
	$StreamWriter = New-Object IO.StreamWriter $LiteralPath, $Append

	$HtOutStringArgs = @{ }
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
		$Input | Out-String -Stream @HtOutStringArgs | % { $StreamWriter.WriteLine($_) }
	}
	finally {
		$StreamWriter.Dispose()
	}

}
    
$NumberOfThreads = 50

if ( $Protocol -eq "http" ) {
	$NumberOfThreads = 100
}

# set paths
$OutputDir = "/$OutputFolder"
$ScriptFullName = "/tests/$JmxTestFileName"
$OutFilename = $OutputDir + "/neo_request_output.csv"

Write-Output "output_dir: $OutputDir"
Write-Output "scriptName: $ScriptFullName"

# set output filenames
$OverallResultsSummary = "neo_results_full.csv"
$OverallAggSummary = "neo_aggregation_full.csv"

# intialise load params
$PreviousTargetHitRate = $Seed1
$CurrentTargetHitRate = $Seed2

if ( $HitRate -gt 0 ) {
	Write-Output "Setting up for a single interation at hit rate of " + $HitRate
	$CurrentTargetHitRate = $HitRate
	$Iterations = 1
}

$LoopCount = 0
#$interations = 10
# begin loop
While ( $LoopCount -lt $Iterations ) {
	$LoopCount += 1

	# run test
	Write-Output "Running jMeter  Test: $ScriptFullName Server: $ServerName Protocol: $Protocol TargerRate: $CurrentTargetHitRate ..."
	Invoke-Expression -Command "jmeter -n -t $ScriptFullName -J HostName=$ServerName -J Protocol=$Protocol -J TargetRate=$CurrentTargetHitRate -J NumberOfThreads=$NumberOfThreads -J Duration=$Duration -j $OutputDir/logfile$LoopCount.log -J SingleLabel=$SingleLabel -J ResultsFile=$OutFilename -J NumberOfConnections=$NumberOfConnections -J BoltRetries=$BoltRetries -J BoltConnectionTimeout=$BoltConnectionTimeout"

	# generate aggregation report
	Write-Output "Generating aggregation report ..."
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-csv $OutputDir/Aggregate_Report_$CurrentTargetHitRate.csv --input-jtl $OutFilename --plugin-type AggregateReport"

	# generate graphs??
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputDir/hits_per_second_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type HitsPerSecond --width 800 --height 400 --granulation 10000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputDir/ResponseTimesOverTime_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type ResponseTimesOverTime --width 800 --height 400 --granulation 10000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputDir/TransactionsPerSecond_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type TransactionsPerSecond --width 800 --height 400 --granulation 10000"

    
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputDir/hits_per_second_a_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type HitsPerSecond --width 800 --height 600 --granulation 20000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputDir/ResponseTimesOverTime_a_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type ResponseTimesOverTime --width 600 --height 400 --granulation 20000"
	Invoke-Expression -Command "$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png $OutputDir/TransactionsPerSecond_a_$CurrentTargetHitRate.png --input-jtl $OutFilename --plugin-type TransactionsPerSecond --width 600 --height 400 --granulation 20000"
	#cmd.exe /v $JMeterBinDir\$JMeterBinDir/PluginsManagerCMD.sh --tool Reporter --generate-png "F:\Jmeter\output\ResponseTimesOverTime_TEST.png" --input-jtl "F:\Jmeter\output\http_request_output.csv" --plugin-type ResponseTimesOverTime
	# add to / initialise overarching results file
	$Output = get-content $OutFilename 
	if ( $LoopCount -eq 1 ) {
		#initalise overarching file
		$Output | select -first 1 | foreach { $_ } | Out-FileUtf8NoBom  $OutputDir/$OverallResultsSummary 
	}
	$Output | select -skip 1 | foreach { $_ } | Out-FileUtf8NoBom -Append $OutputDir/$OverallResultsSummary #>> $OutputBaseDir\$OverallResultsSummary

	#add to / initialise overaching aggregation report
	$Output2 = get-content $OutputDir/Aggregate_Report_$CurrentTargetHitRate.csv
	if ( $LoopCount -eq 1 ) {
		#initalise overarching file
		#$Output2 | select -first 1 | foreach  {"protocol,target_workload," + $_ } > $OutputBaseDir\$OverallAggSummary
		Write-Output "Protocol,Target Workload,Request,# Samples,Average,Median,90% Line,95% Line,99% Line,Minimum,Maximum,Error %,Throughput,Bandwith,Stddev" | Out-FileUtf8NoBom  $OutputDir/$OverallAggSummary
	}
	$Output2 | select -skip 1 | foreach { $Protocol + "," + $CurrentTargetHitRate + "," + $_ } | Out-FileUtf8NoBom -Append $OutputDir/$OverallAggSummary

	# add to overarching aggregration report
	# https://stackoverflow.com/questions/9813228/add-rows-to-csv-file-in-powershell

	# increment load params
	$newTargetHitRate = $PreviousTargetHitRate + $CurrentTargetHitRate
	$PreviousTargetHitRate = $CurrentTargetHitRate
	$CurrentTargetHitRate = $newTargetHitRate

}
# end loop

# generate overarching test report
Remove-Item  -Recurse $OutputDir/report

Invoke-Expression -Command "jmeter -g $OutputDir/$OverallResultsSummary -o $OutputDir/report"
