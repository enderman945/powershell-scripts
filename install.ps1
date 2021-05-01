New-Item -ItemType Directory -Path ./temp/ | Out-Null
Set-Location ./temp/
git clone https://github.com/enderman945/powershell-scripts/

New-Item -ItemType Directory -Path ./ -Name wf-backup
Copy-Item -Path ./ -Destination