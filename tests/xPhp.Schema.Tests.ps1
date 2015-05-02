<# 
.summary
    Test suite for ExportToHtml.psm1
#>
[CmdletBinding()]
param()

$xPhpModuleRoot = "${env:ProgramFiles}\WindowsPowerShell\Modules\xPhp"

if(!(test-path $xPhpModuleRoot))
{
    md $xPhpModuleRoot > $null
}
Copy-Item -Recurse  $PSScriptRoot\..\* $xPhpModuleRoot -verbose -force

$ErrorActionPreference = 'stop'
Set-StrictMode -Version latest

function Suite.BeforeAll {
    # Remove any leftovers from previous test runs
    Suite.AfterAll 

}

function Suite.AfterAll {
}

function Suite.BeforeEach {
}

try
{
    Describe 'xPhpProvision' {
        BeforeEach {
            Suite.BeforeEach
        }

        AfterEach {
        }


            It 'Should return from Get-DscResource' {
                $xphp = Get-DscResource -Name xPhpProvision
                $xphp.ResourceType | should be 'xPhpProvision'
                $xphp.Module | should be 'xPhp'
                $xphp.ModuleName | should be 'xPhp'
                $xphp.FriendlyName | should BeNullOrEmpty
                $xphp.ResourceName | should be 'xPhpProvision'
                $xphp.ImplementedAs | should be 'Composite'
                $xphp.Properties
            }
            It 'Should return a static color' {
                [HashTable] $hashtable = @{foo={write-output 'testcolor'}}
                Get-BackgroundColorStyle -columnValue 'foo' -propertyName 'foo' -columnBackgroundColor $hashtable -this $null| should be "background-color:testcolor"
            }
            It 'Should return using this' {
                [HashTable] $hashtable = @{foo={write-output $this.bar}}
                [HashTable] $hashtable2 = @{bar='testcolor2'}
                Get-BackgroundColorStyle -columnValue 'foo' -propertyName 'foo' -columnBackgroundColor $hashtable -this $hashtable2| should be "background-color:testcolor2"
            }
            It 'Should return using columnValue' {
                [HashTable] $hashtable = @{foo={ if($columnValue -eq 'foo') {write-output 'testcolor3'} else {write-output 'fail'}}}
                Get-BackgroundColorStyle -columnValue 'foo' -propertyName 'foo' -columnBackgroundColor $hashtable -this $null| should be "background-color:testcolor3"
            }
    }


}
finally
{
    Suite.AfterAll
}

