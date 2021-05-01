# Ceci est un programme de sauvegarde automatique d'un dossier en cas de perte des documents.
# par enderman_95_

Set-Location $saveto
Clear-Host
Write-Host -ForegroundColor Green "Démarrage de la copie : "
$date = Get-Date -Format "dd.MM.yyyy - HH.mm"
Copy-Item -Path "$savefrom" -Destination "$saveto$date" -Recurse 
$cperr = $?
$cperrd = Get-Error
Compress-Archive -Path "./$date" -DestinationPath "$date.zip"
Remove-Item "$date" -Recurse
if ($cperr -eq "True") {
    $cperr = "Sauvegardé avec succés "
}
elseif ($cperr -eq "False") {
    $cperr = "Erreur lors de la copie"
    Clear-Host
    Write-Host "$cperr"
}
else {
    Write-Host "Erreur : révision du code nécéssaire"
    $cperr = "Erreur : révision du code nécéssaire"
}
$detectlogfile = Get-ChildItem -File -Name logs.txt -ErrorAction "silentlycontinue" | Out-Null
if ( $detectlogfile -ne "logs.txt" ) 
{ 
    Add-Content -Path "./logs.txt" "$date : $cperr"
}
else {
    New-Item -ItemType File -Path "./logs.txt" | Out-Null
    Add-Content -Path "./logs.txt" "$date : $cperr"
}
if ($cperrd -ne "" ) {
    Get-ChildItem -Path "$saveto/Errors/" -ErrorAction "silentlycontinue" | Out-Null
    $detecterrfile = $?
    if ($detecterrfile -ne "False") {
          New-Item -ItemType Directory -Path "$saveto/Errors/" | Out-Null
          New-Item -ItemType File -Path "$saveto/Errors/$date.log" | Out-Null
          Add-Content -Path "$saveto/Errors/$date.log" "$cperrd"
    }
    else {
        New-Item -ItemType File -Path "$saveto/Errors/$date.log" | Out-Null
        Add-Content -Path "$saveto/Errors/$date.log" "$cperrd"
    }
}
Write-Host $cperrd
Write-Host -ForegroundColor Green "$cperr !"