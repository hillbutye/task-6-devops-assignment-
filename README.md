# Task 6 Jenkins Multibranch Pipeline

A small Java MRM inventory sample and persistent local Jenkins controller setup.
The Compose port mapping asks Docker to allocate an available host port for
Jenkins container port 8080, reducing collisions with services already on the PC.

## Start Jenkins on Windows PowerShell

From this folder run:

```powershell
.\Start-Task6.ps1
```

The script reports the current browser URL and writes it to `jenkins-url.txt`.
Jenkins state is kept in the named Docker volume `jenkins_home` across restarts.
The initial administrator password is printed on first start. Treat it as a
secret and do not commit it.

## Complete the live GitHub task

1. Push this folder's contents to a GitHub repository you control.
2. In Jenkins install/enable **Pipeline: Multibranch** and **GitHub Branch Source**.
3. Add a GitHub token in Jenkins Credentials as a Secret Text credential. Give it
   only repository read/metadata permissions needed for branch discovery. Never
   put the token in this repository or in a Jenkinsfile.
4. Create **New Item > Multibranch Pipeline**. Under Branch Sources add GitHub,
   select the stored credential and your owner/repository. Enable branch
   discovery for all branches. Save, then select **Scan Multibranch Pipeline Now**.
5. Create and push a branch, for example `feature/stock-alerts`, that contains
   the root `Jenkinsfile`. Scan again or use a GitHub webhook and confirm the
   branch appears as a child job and runs Build, Test, and Package.
6. To enable webhook-triggered scans, expose Jenkins through a trusted HTTPS
   endpoint and configure the repository webhook to that URL. Do not expose an
   unauthenticated controller directly to the public internet.

This package does not contain a GitHub account, repository URL, token, webhook,
or live Jenkins run. Complete those account-specific actions locally.

## Stop and cleanup

```powershell
docker compose down
```

This stops the controller and preserves `jenkins_home`. To permanently erase all
Jenkins configuration and build history, use `docker compose down --volumes`.
