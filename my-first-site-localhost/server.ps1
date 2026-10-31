# 1. CHANGED: Lowered count to simulate a valid username (under 3 strikes)
$timerCount = 1 

if ($timerCount -ge 3) {
    $totalSeconds = 24 * 60 * 60
    Write-Host "Condition High: 24-Hour Timer Active" -ForegroundColor Red
} else {
    $totalSeconds = 5 * 60
    Write-Host "Condition Met! Switched to 5-Minute Timer." -ForegroundColor Green
}

# 2. Update files immediately
$hours = [math]::Floor($totalSeconds / 3600)
$minutes = [math]::Floor(($totalSeconds % 3600) / 60)
$seconds = $totalSeconds % 60
$timeString = "{0:D2}:{1:D2}:{2:D2}" -f $hours, $minutes, $seconds

Set-Content -Path .\timer.txt -Value $timeString

$jsonObject = [PSCustomObject]@{
    username_valid = $true
    status          = "active"
    time_remaining  = $timeString
    display_message = "Username accepted. Game access is paused for $timeString."
}
$jsonObject | ConvertTo-Json | Set-Content -Path .\data.json
Write-Host "Local files updated to 5 minutes!" -ForegroundColor Green
