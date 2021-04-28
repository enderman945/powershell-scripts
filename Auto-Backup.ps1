# Ceci est un programme de sauvegarde automatique d'un dossier en cas de perte des documents.
# par enderman_95_

do {
    Clear-Host
    $savefrom = Read-Host "Quel dossier voulez-vous sauvegarder ? "
    $saveto = Read-Host "Vers où voulez-vous le sauvegarder ? "

    Clear-Host
    Write-Host -ForegroundColor red "Vérification : " -NoNewline
    $verif = Read-Host "Voulez-vous bien sauvegarder vos fichiers de $savefrom vers $saveto ? (Y/n) "
    if (($verif -eq "") -or ($verif -contains "y"))
        {}
    elseif ($verif -contains "n")
        { Clear-Host
          Write-Host "Revérification :"}
    else
        { Clear-Host
        Write-Host -ForegroundColor Red "Erreur : " -NoNewline
        Write-Host "$verif n'est pas une variable valide" }
} until ( ($verif -eq "") -or ($verif -contains "y" ) )

if (($savefrom -eq "") -and ($saveto -eq ""))
{
    $savefrom = "/home/env:USERNAME/Documents/Projets/"
    $saveto = "/home/env:USERNAME/Documents/Sauvegardes/"
}
else {
    
}

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
    $cperr = "Sauvegardé avec succés"
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
$detectlogfile = Get-ChildItem -File -Name logs.txt
if ( $detectlogfile -eq "logs.txt" ) 
{ 
    Add-Content -Path "./logs.txt" "$date : $cperr"
}
else {
    New-Item -ItemType File -Path "./logs.txt"
    Add-Content -Path "./logs.txt" "$date : $cperr"
}
if ($cperrd -ne "" ) {
  New-Item -ItemType Directory -Path "$saveto/Errors/"
  New-Item -ItemType File -Path "$saveto/Errors/$date.log"
  Add-Content -Path "$saveto/Errors/$date.log" "$cperrd"
}