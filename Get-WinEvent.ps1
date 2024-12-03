# Define the directory containing the event logs and search string
$logDirectory = "C:\Tools\chainsaw\EVTX-ATTACK-SAMPLES\Lateral Movement"
$searchString = "\\\\.*\\PRINT"  # Regex pattern to match the \\*\PRINT share
$eventId = $null  # Specify Event ID here or leave as $null to process all Event IDs

# Traverse and filter event logs
Get-ChildItem -Path $logDirectory -Filter *.evtx | ForEach-Object {
    Write-Host "Processing file: $($_.FullName)"
    Get-WinEvent -Path $_.FullName | Where-Object { 
        ($eventId -eq $null -or $_.Id -eq $eventId) -and $_.Message -match $searchString 
    } | ForEach-Object {
        Write-Host "Event Found:"
        Write-Host "Event ID: $($_.Id)"
        Write-Host "Time Created: $($_.TimeCreated)"
        Write-Host "Message: $($_.Message)"
        Write-Host "----"
    }
}
