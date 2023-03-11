$destinationPath = "$($PSHOME.Split(';')[0])/Modules"

Write-Host "Copying Search-Scoop module to `$PSHOME folder..." -ForegroundColor Black
Copy-Item ".\Search-Scoop\" $destinationPath -Recurse -Force

Write-Host "Done! Reset the terminal to load the module."
