$destinationPath = "$($PSHOME.Split(';')[0])/Modules"

Copy-Item ".\Search-Scoop\" $destinationPath -Recurse -Force
