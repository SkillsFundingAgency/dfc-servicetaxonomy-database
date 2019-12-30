param
(
    [string]$protocol="http",
    [string]$serverName="localhost",
    [int]$duration=120,
    [int]$numberOfThreads=1,
    [int]$numberOfConnections=1,
   [int]$iterations=1,
   [string]$outputFolder="test1",
   [int]$hitRate=0,
   [string]$SingleLabel="N",
   [string]$BaseDir="F:\Jmeter",
   [string]$jmxName="NeoLoadTest.jmx",
   [int]$Seed1=1,
   [int]$Seed2=1,
   [int]$BoltRetries=2,
   [int]$BoltConnectionTimeout=60

)


Write-Output "Protocol:" + $protocol;
Write-Output "ServerName:" + $serverName;
Write-Output "Durations:" + $duration;
Write-Output "NumberOfThreads:" + $numberOfThreads;
Write-Output "iterations:" + $interations;
Write-Output "Single Label:" + $SingleLabel;
Write-Output "hitRate override:" + $hitRate;
Write-Output "number of connections:" + $numberOfConnections;

#exit;
function Out-FileUtf8NoBom {

  [CmdletBinding()]
  param(
    [Parameter(Mandatory, Position=0)] [string] $LiteralPath,
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
  $sw = New-Object IO.StreamWriter $LiteralPath, $Append

  $htOutStringArgs = @{}
  if ($Width) {
    $htOutStringArgs += @{ Width = $Width }
  }

  # Note: By not using begin / process / end blocks, we're effectively running
  #       in the end block, which means that all pipeline input has already
  #       been collected in automatic variable $Input.
  #       We must use this approach, because using | Out-String individually
  #       in each iteration of a process block would format each input object
  #       with an indvidual header.
  try {
    $Input | Out-String -Stream @htOutStringArgs | % { $sw.WriteLine($_) }
  } finally {
    $sw.Dispose()
  }

}
    


#set run params
#$protocol = "http"
#$serverName = "dfc-dev-stax-shared-neo4j-aci.westeurope.azurecontainer.io"
#$serverName = "localhost"
#$duration = "300"

$numberOfThreads = 50

if ( $protocol -eq "http" )
{
    $numberOfThreads = 100
}

# set paths
$jmeter_bin = $BaseDir + "\apache-jmeter-5.1.1\bin"
$output_base = $BaseDir + "\output"
$output_dir = $output_base + "\" + $outputFolder
$scriptName = $BaseDir + "\Neo4j\" + $jmxName #NeoLoadTestPortableSingleDriverWithPool.jmx"
$outFilename = $output_dir + "\neo_request_output.csv"

Write-Output "output_dir:" + $output_dir
Write-Output "scriptName:" + $scriptName

# set output filenames
$overall_results_summary = "neo_results_full.csv"
$overall_agg_summary = "neo_aggregation_full.csv"



# intialise load params
$previousTargetHitRate = $Seed1
$currentTargetHitRate = $Seed2

if ( $hitRate -gt 0 )
{
    Write-Output "Setting up for a single interation at hit rate of " + $hitRate
    $currentTargetHitRate = $hitRate
    $iterations = 1
}

$loop_count = 0
#$interations = 10
# begin loop
While ( $loop_count -lt $iterations )
{
    $loop_count += 1

    New-Item -Path $output_base -Name $outputFolder -ItemType "directory"
    #clear down results file
    Remove-Item $outFilename

    # run test
    Write-Output "Running JMETER  Test: " + $scriptName + "  Server:" + serverName + " Protocol:" + $protocol + " TargerRate: " + $currentTargetHitRate
    cmd.exe /c $jmeter_bin\jmeter -n -t $scriptName -J HostName=$serverName -J Protocol=$protocol -J TargetRate=$currentTargetHitRate -J NumberOfThreads=$numberOfThreads -J Duration=$duration -j $output_dir/logfile$loop_count.log -J SingleLabel=$SingleLabel -J ResultsFile=$outFilename -J NumberOfConnections=$numberOfConnections -J BoltRetries=$BoltRetries -J BoltConnectionTimeout=$BoltConnectionTimeout

    # generate aggregation report
    cmd.exe /c $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-csv $output_dir\Aggregate_Report_$currentTargetHitRate.csv --input-jtl $outFilename --plugin-type AggregateReport

    # generate graphs??
    cmd.exe /c  $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png $output_dir\hits_per_second_$currentTargetHitRate.png --input-jtl $outFilename --plugin-type HitsPerSecond --width 800 --height 400 --granulation 10000
    cmd.exe /c  $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png $output_dir\ResponseTimesOverTime_$currentTargetHitRate.png --input-jtl $outFilename --plugin-type ResponseTimesOverTime --width 800 --height 400 --granulation 10000
    cmd.exe /c  $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png $output_dir\TransactionsPerSecond_$currentTargetHitRate.png --input-jtl $outFilename --plugin-type TransactionsPerSecond --width 800 --height 400 --granulation 10000

    
    cmd.exe /c  $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png $output_dir\hits_per_second_a_$currentTargetHitRate.png --input-jtl $outFilename --plugin-type HitsPerSecond --width 800 --height 600 --granulation 20000
    cmd.exe /c  $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png $output_dir\ResponseTimesOverTime_a_$currentTargetHitRate.png --input-jtl $outFilename --plugin-type ResponseTimesOverTime --width 600 --height 400 --granulation 20000
    cmd.exe /c  $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png $output_dir\TransactionsPerSecond_a_$currentTargetHitRate.png --input-jtl $outFilename --plugin-type TransactionsPerSecond --width 600 --height 400 --granulation 20000
    #cmd.exe /v $jmeter_bin\PluginsManagerCMD.bat --tool Reporter --generate-png "F:\Jmeter\output\ResponseTimesOverTime_TEST.png" --input-jtl "F:\Jmeter\output\http_request_output.csv" --plugin-type ResponseTimesOverTime
    # add to / initialise overarching results file
    $output = get-content $outFilename 
    if( $loop_count -eq 1 )
    {
        #initalise overarching file
        $output | select -first 1 | foreach  { $_ } | Out-FileUtf8NoBom  $output_dir\$overall_results_summary 
    }
    $output | select -skip 1 | foreach  { $_ } | Out-FileUtf8NoBom -Append $output_dir\$overall_results_summary #>> $output_base\$overall_results_summary

    #add to / initialise overaching aggregation report
    $output2 = get-content $output_dir\Aggregate_Report_$currentTargetHitRate.csv
    if( $loop_count -eq 1 )
    {
        #initalise overarching file
        #$output2 | select -first 1 | foreach  {"protocol,target_workload," + $_ } > $output_base\$overall_agg_summary
        Write-Output "Protocol,Target Workload,Request,# Samples,Average,Median,90% Line,95% Line,99% Line,Minimum,Maximum,Error %,Throughput,Bandwith,Stddev" | Out-FileUtf8NoBom  $output_dir\$overall_agg_summary
    }
    $output2 | select -skip 1 | foreach  { $protocol + "," + $currentTargetHitRate + "," + $_ } | Out-FileUtf8NoBom -Append $output_dir\$overall_agg_summary


    # add to overarching aggregration report
    # https://stackoverflow.com/questions/9813228/add-rows-to-csv-file-in-powershell

    # increment load params
    $newTargetHitRate = $previousTargetHitRate + $currentTargetHitRate
    $previousTargetHitRate = $currentTargetHitRate
    $currentTargetHitRate = $newTargetHitRate

}
# end loop

# generate overarching test report
Remove-Item  -Recurse $output_dir\report

cmd.exe /c $jmeter_bin\jmeter -g $output_dir\$overall_results_summary -o $output_dir\report
