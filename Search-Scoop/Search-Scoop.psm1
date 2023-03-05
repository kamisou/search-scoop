function Search-Scoop {
    param (
        [string] $Package,
        [switch] $SearchDescriptions
    )

    $scoopHome = $env:SCOOP_HOME ?? "${HOME}\scoop";

    foreach ($bucket in Get-ChildItem "${scoopHome}\buckets\") {
        $apps = "$($bucket.FullName)\bucket";

        foreach ($app in Get-ChildItem $apps -Filter '*.json') {
            $appData = $null;

            if ($app.BaseName -notmatch $Package) {
                if (!$SearchDescriptions) {
                    continue;
                }
                else {
                    $appData = (Get-Content $app) | ConvertFrom-Json -AsHashtable;
                    if ($appData.description -notmatch $Package) {
                        continue;
                    }
                }
            }

            $appData ??= (Get-Content $app) | ConvertFrom-Json -AsHashtable;

            $32bit = $appData.architecture?['32bit'];
            $64bit = $appData.architecture?['64bit'];
            $architecture = $32bit ? $64bit ? "all" : "x86_64" : "amd64";

            Write-Host $app.BaseName -ForegroundColor Green -NoNewLine;
            Write-Output "/$($bucket.BaseName) $($appData.version) $architecture";
            Write-Output "  $($appData.description)";
		    Write-Output "";
        }
    }
}
