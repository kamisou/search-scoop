# Search-Scoop
A PowerShell script for searching scoop packages in your buckets using regular expressions. Results are formatted like apt.

![An example of Search-Scoop on Windows PowerShell.](/media/example.png)

## Instalation
Drop the `SearchScoop` folder in one of your `$env:PSModulePath`

## Usage
```ps1
SearchScoop [-Package] <string> [[-SearchDescriptions] <switch>]
```

## Notes
If your scoop installation folder is not in ```~/scoop```, you can set a ```SCOOP_HOME``` environment variable to that location.
