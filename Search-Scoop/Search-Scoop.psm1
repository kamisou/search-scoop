<#
.Synopsis
Searches for Scoop packages in the local buckets.
.Parameter Package
Regex pattern specifying the search term.
.Parameter Bucket
Bucket to search for packages on.
.Parameter SearchDescriptions
Search package descriptions for the search term. Due to the parsing performed in the package files, causes the search to be slower.
.Example
PS> Search-Scoop 'scoop' 'extras' -SearchDescriptions
scoop-completion/extras 0.2.4 amd64
  A Scoop tab completion module for PowerShell

scoop-sd/extras 0.3 amd64
  A program to search for scoop packages. Powered by https://scoopsearch.github.io/

sfsu/extras 1.4.6 all
  Stupid Fast Scoop Utilities. Incredibly fast replacements for commonly used Scoop commands, written in Rust.

wingetui/extras 1.6.0 amd64
  A GUI to manage Winget and Scoop packages
#>
function Search-Scoop {
    param (
        [parameter(Mandatory=$false)]
        [string] $Package,
        [parameter(Mandatory=$false)]
        [string] $Bucket,
        [switch] $SearchDescriptions
    )

    $scoopHome = $env:SCOOP_HOME ?? "${HOME}\scoop";

    foreach ($scoopBucket in Get-ChildItem "${scoopHome}\buckets\") {
        if ($Bucket -and ($scoopBucket.BaseName -ne $Bucket)) {
            continue;
        }

        foreach ($scoopPackage in Get-ChildItem "$($scoopBucket.FullName)\bucket" -Filter '*.json') {
            $appData = $null;

            try {
                if ($scoopPackage.BaseName -notmatch $Package) {
                    if ($SearchDescriptions -and $Package) {
                        $appData = (Get-Content $scoopPackage) | ConvertFrom-Json -AsHashtable;

                        if ($appData.description -notmatch $Package) {
                            continue;
                        }
                    }
                    else {
                        continue;
                    }
                }
            } catch [System.Text.RegularExpressions.RegexParseException] {
                Write-Host "`"$Package`" is not a valid regex pattern. Stopping..." -ForegroundColor Red;
                return;
            }

            $appData ??= (Get-Content $scoopPackage) | ConvertFrom-Json -AsHashtable;

            $32bit = $appData.architecture?['32bit'];
            $64bit = $appData.architecture?['64bit'];
            $architecture = $32bit ? $64bit ? "all" : "x86_64" : "amd64";

            Write-Host $scoopPackage.BaseName -ForegroundColor Green -NoNewLine;
            Write-Output "/$($scoopBucket.BaseName) $($appData.version) $architecture";
            Write-Output "  $($appData.description)";
		    Write-Output "";
        }
    }
}
