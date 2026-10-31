# Mock configurations for testing the bad username penalty state
$usernameStatus = "inappropriate"
$mockRemainingTime = "00:05:00"

Write-Host "Simulating appropriate/non-appropriate input states..." -ForegroundColor Cyan

if ($usernameStatus -eq "inappropriate") {
    Write-Host "Triggered: Writing 5-min lockout state to output files." -ForegroundColor Red
    
    # 1. Option A Output: Standard Text File Configuration
    $plainTextContent = "That username was not appropriate. Each inappropriate attempt adds 5 minutes. Game access is paused for $mockRemainingTime."
    Set-Content -Path .\timer.txt -Value $plainTextContent

    # 2. Option B Output: Custom JSON Object Configuration
    $jsonObject = [PSCustomObject]@{
        username_valid = $false
        status          = "paused"
        time_remaining  = $mockRemainingTime
        display_message = "That username was not appropriate. Each inappropriate attempt adds 5 mins. Game access is paused for $mockRemainingTime."
    }
    $jsonObject | ConvertTo-Json | Set-Content -Path .\data.json
    
    Write-Host "Files updated successfully. Check timer.txt or data.json inside VS Code!" -ForegroundColor Green
} else {
    Write-Host "Username accepted. Standard timer applied." -ForegroundColor Green
}
