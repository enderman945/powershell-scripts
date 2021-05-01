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
    $savefrom = "/home/$env:USERNAME/Documents/Projets/"
    $saveto = "/home/$env:USERNAME/Documents/Sauvegardes/"
}

