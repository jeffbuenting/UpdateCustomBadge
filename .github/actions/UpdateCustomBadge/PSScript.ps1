<#
    .LINKS
        https://shields.io/
#>

[cmdletBinding()]
Param (
  #  [String]$FileName = $env:INPUT_FILENAME,
  #
  #  [String]$Label = 'Version',
  #
  #  [String]$Message = 9.9.9,
  #
  #  [ValidateSet ('brightgreen','green','yellowgreen','yellow','orange','red','blue','lightgrey','success','important','critical','informational','inactive','blueviolet','ff69b4','9cf')]
  #  [String]$Color
)

if ( $env:INPUT_VERBOSE ) { $VerbosePreference = 'Continue' }

$FileName = $env:INPUT_FILENAME


# ----- Grab the file
Try {
    $File = get-childitem . -ErrorAction Stop | where { $_.Name.toupper() -EQ $FileName.ToUpper() }

    $FileTxt = Get-Content -Path $File.FullName -ErrorAction Stop

    Write-Verbose "$FileName = `n$FileTxt"
}
Catch {
    Write-Error "Error getting file $FileName"
    Exit 1
}

# ----- get the existing badge link
Try {
    # ----- getting link and removing surrounding ()
    $ExistingBadge = ($FileTxt | Select-String -Pattern "(\(https:\/\/img\.shields\.io\/badge\/Version-.*-.*\))" -ErrorAction Stop | foreach { $_.Matches.Groups[1].Value }).trimstart( '(' ).Trimend( ')' )

    # ----- Get the existing badge parameters
    $MatchingGroups = $ExistingBadge | Select-String -Pattern "https:\/\/img\.shields\.io\/badge\/Version-(.*)-(.*)" -ErrorAction Stop | foreach { $_.Matches.Groups }
    $ExistingMessage = $MatchingGroups[1].Value
    $ExistingColor = $MatchingGroups[2].Value

    Write-Verbose "Existing Badge = $ExistingBadge"
    Write-Verbose "Existing Message = $ExistingMessage"
    Write-Verbose "Existing Color = $ExistingColor"
}
Catch {
    Write-Error "Error Finding existing badge"
    Exit 1
}

# ----- New Badge link
if ( $Message -and $Color ) {
    $FileTxt = $FileTxt -replace "$ExistingBadge","https://img.shields.io/badge/$Label-$Message-$Color"
}
Elseif ( $Message ) {
    $FileTxt = $FileTxt -replace "$ExistingBadge","https://img.shields.io/badge/$Label-$Message-$ExistingColor"
}
Elseif ( $Color ) {
    $FileTxt = $FileTxt -replace "$ExistingBadge","https://img.shields.io/badge/$Label-$ExistingMessage-$Color"
}

Write-Verbose "New$FileName = `n$FileTxt"

Try {
    $FileTxt | Set-Content -Path $File.FullName -ErrorAction Stop
}
Catch {
    Write-Error "Error saving $FileName"
    Exit 1
}

Exit 0


