param(
    [Parameter(Mandatory=$true)][string]$RemoteUrl,
    [string]$Branch = 'feature/stock-alerts'
)
$ErrorActionPreference = 'Stop'
$folder = Join-Path $env:TEMP 'task6-mrm-multibranch'
if (Test-Path -LiteralPath $folder) { throw "Working folder already exists: $folder. Remove it or choose another temp folder." }
git clone $RemoteUrl $folder
if ($LASTEXITCODE -ne 0) { throw 'git clone failed; check repository URL and access.' }
Set-Location $folder
git switch -c $Branch
if ($LASTEXITCODE -ne 0) { throw 'Could not create the requested branch.' }
# Add a harmless feature marker so the branch has a concrete change.
Set-Content -LiteralPath 'FEATURE_BRANCH.md' -Value "Sample branch $Branch for Jenkins multibranch discovery." -Encoding utf8
git add FEATURE_BRANCH.md
git commit -m "Add sample stock alerts branch marker"
if ($LASTEXITCODE -ne 0) { throw 'Commit failed; configure Git author name and email, then retry.' }
git push -u origin $Branch
if ($LASTEXITCODE -ne 0) { throw 'Push failed; check GitHub authentication and branch permissions.' }
Write-Host "Pushed $Branch. Scan the Jenkins multibranch job to confirm discovery."
