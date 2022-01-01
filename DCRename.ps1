<#
================================================================================================
    AD DC Rename Helper Script: RenameDC.ps1

    Powershell script to help you rename the domain controller hostname. 

    Author: Scarred Monk (@ScarredMonk)

================================================================================================
#>

<#
.Synopsis
   Provides assistance in renaming the DC hostname.  
.DESCRIPTION
   The goal of AD DC Rename script is to provide the commands to rename DC successfully. 
.EXAMPLE
   Import-Module .\DCRename.ps1; Invoke-RenameDC -OldDCName WIN-PJEKEQ9GTTN.rootdse.org -NewDCName RDSDC01.rootdse.org
#>

Write-Host ""
function DisplayInfo {
    $info = '#====== Invoke-RenameDC Helper script ======#'
	Write-Host $info -ForegroundColor "Yellow"
}

function RenameDC {
    Write-Host "[*] Old Domain controller is called $OldDCName" -ForegroundColor Green
    Write-Host "[*] New hostname for Domain Controller should be $NewDCName" -ForegroundColor Green
    Write-Host ""
    Write-Host "[!] Step 1 - Take backup of your VM so you can in case something goes wrong" -ForegroundColor Gray
    Write-Host ""
    Write-Host "[+] Make sure to run below commands in an elevated command prompt (in same order)" -ForegroundColor DarkGreen
    Write-Host ""
    Write-Host "[!] Step 2 - Add New DC Name using below command" -ForegroundColor Gray
    Write-Host "netdom computername $OldDCName /add:$NewDCName" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[!] Step 3 - Set New DC Name as primary using below command" -ForegroundColor Gray
    Write-Host "netdom computername $OldDCName /makeprimary:$NewDCName" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[!] Step 4 - Reboot the server using below command" -ForegroundColor Gray
    Write-Host "shutdown /r /t 0" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[!] Step 4 - Remove the old hostname entry from the server using below command" -ForegroundColor Gray
    Write-Host "netdom computername $NewDCName /remove:$OldDCName" -ForegroundColor Yellow
    
    }

function Invoke-RenameDC
{
	Param(
	[Parameter(Mandatory=$True)]
	[ValidateNotNullOrEmpty()]
	[System.String]
	$OldDCName,
    [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,Position=1)]
    [ValidateNotNullOrEmpty()]
    [System.String]$NewDCName)
    Write-Host ""
    DisplayInfo
    Write-Host ""
    RenameDC
}