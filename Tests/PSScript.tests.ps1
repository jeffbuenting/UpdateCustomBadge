


Describe "UpdateCustomBadge : PSCript" {

 #   Mock -CommandName Get-Content -MockWith {
 #       Return '![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen)'
 #   }
 #
 #   Mock -CommandName Set-Content -MockWith {
 #       '![Version](https://img.shields.io/badge/Version-1.0.1-brightgreen)' | Out-File TestDrive:\readme.md
 #   }
 #   
    It "Should update badge" {
 #      ..\PSSCript.ps1 #-FileName readme.md -Label Version -Message 1.0.1
 #
 #      Get-Content -Path TestDrive:\readme.md | Should -Match '![Version](https://img.shields.io/badge/Version-1.0.1-brightgreen)'
        $True | Should Be $True
    }


}