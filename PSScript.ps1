<#
    .LINKS
        https://shields.io/
#>

[cmdletBinding()]
Param (
    [Parameter (Mandatory = $True)]
    [String]$FileName,

    [Parameter (Mandatory = $True)]
    [String]$Label,

    [String]$Message,

    [ValidateSet ('brightgreen','green','yellowgreen','yellow','orange','red','blue','lightgrey','success','important','critical','informational','inactive','blueviolet','ff69b4','9cf')]
    [String]$Color
)

# ----- Grab the file
Try {
    $FileTxt = Get-Content -Path ./$FileName -ErrorAction Stop

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
    $FileTxt | Set-Content -Path ./$FileName -ErrorAction Stop
}
Catch {
    Write-Error "Error saving $FileName"
    Exit 1
}

Exit 0


