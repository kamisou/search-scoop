# Search-Scoop
A PowerShell script for searching scoop packages in your buckets using regular expressions. Results are formatted like apt.

![An example of Search-Scoop on Windows PowerShell.](/media/example.png)

## Instalation
Run the `Install.ps1` script in your PowerShell terminal.

## Usage
```ps1
Search-Scoop [[-Package] <string>] [[-Bucket] <string>] [-SearchDescriptions]
```

## Notes
If your scoop installation folder is not in `~/scoop`, you can set a `SCOOP_HOME` environment variable to that location.
