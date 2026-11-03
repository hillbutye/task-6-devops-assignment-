$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw 'Docker CLI was not found. Install and start Docker Desktop, then rerun this script.'
}
docker info *> $null
if ($LASTEXITCODE -ne 0) {
    throw 'Docker Engine is not reachable. Start Docker Desktop and wait until it is running.'
}
docker compose up -d
if ($LASTEXITCODE -ne 0) { throw 'docker compose up failed; review the Docker Compose error above.' }
$mapping = docker compose port jenkins 8080
if (-not $mapping) { throw 'Jenkins port mapping is not ready yet. Wait a minute and run this script again.' }
$port = ($mapping | Select-Object -Last 1) -replace '^.*:', ''
$url = "http://localhost:$port"
Set-Content -LiteralPath (Join-Path $here 'jenkins-url.txt') -Value $url -Encoding utf8
Write-Host "Jenkins is starting at $url"
Write-Host 'First startup can take several minutes. Initial administrator password:'
docker exec task6-jenkins sh -c 'cat /var/jenkins_home/secrets/initialAdminPassword' 2>$null
if ($LASTEXITCODE -ne 0) { Write-Host 'Password file is not ready yet. Retry: docker exec task6-jenkins cat /var/jenkins_home/secrets/initialAdminPassword' }
