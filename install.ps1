###########################################################################################################
# Install script for Azure namespaces                                                                     #
# In future this can be used as a ground for more automatical deployments for az commands (Azures cli)    #
#                                                                                                         #
# Maintainer Stellan Eriksson micro_se@hotmail.com                                                        #
# Written    2019-06-12                                                                                   #
#                                                                                                         #
###########################################################################################################

Write-Host "Deploy a namespace to Azure"
Write-Host ' '

# First we need to login to Azure with your AD account!"
$login = 'First we need to login to Azure with your AD account! [Y/N]'
do {
    $response_login = Read-Host -Prompt $login
    if ($response_login -eq 'y') {
		az login
		Write-Host ' '
	}	
} until ($response_login -eq 'n')


#List Available account
Write-Host ' '
Write-Host "Available account"
Write-Host ' '
az account list --query '[].{name:name}' --output table
Write-Host ' '

#Use the right account"
$account = Read-Host -Prompt 'Please enter the "Name" of the account you want to use and press [ENTER] '
Write-Host ' '

#Set the account
az account set --subscription $account
Write-Host ' '

#List the account
az account list --query '[].{Name:name, IsDefault:isDefault}' --output table | Select-String -Pattern 'True' -CaseSensitive -SimpleMatch
Write-Host ' '

$msg = 'Right account? [Y/N]'
do {
    $response = Read-Host -Prompt $msg
    if ($response -eq 'n') {
        
		
		Write-Host 'We try again..... '
		Write-Host ' '
		az account list --query '[].{name:name}' --output table
		Write-Host ' '
		$account = Read-Host -Prompt 'Please enter the "Name" of the account you want to use and press [ENTER] '
		Write-Host ' '
		az account set --subscription $account
		Write-Host ' '
		az account list --query '[].{Name:name, IsDefault:isDefault}' --output table | Select-String -Pattern 'True' -CaseSensitive -SimpleMatch
    }
} until ($response -eq 'y')



#################################################################
#
# Was planing to put a menu here to do more Azure deployments
# Make include of this type of scripts
#
# 1. Adding teams to the project
# 2. Adding VSTS groups
# 3. Adding a Git Repo
# 4. Adding security to groups within the project
#
#
# Include required files 
#



$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\azure_devops\AddTeam.ps1")
    . ("$ScriptDirectory\azure_devops\AddVSTS.ps1")
    . ("$ScriptDirectory\azure_devops\AddGitrepo.ps1")
    . ("$ScriptDirectory\azure_devops\AddSecGroup.ps1")
}
catch {
    Write-Host "Error while loading supporting PowerShell Scripts" 
}

function Show-Menu
{
    param (
        [string]$Title = 'Menu'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Adding namespace."
	Write-Host "2: Adding teams to the project."
    Write-Host "3: Adding VSTS groups."
    Write-Host "4: Adding a Git Repository."
	Write-Host "5: Adding security to groups within the project."
    Write-Host "Q: Press 'Q' to quit."
}

	
do 
{ 
     Show-Menu 
     $input = Read-Host "Please make a selection" 
     switch ($input) 
     { 
           '1' { 
                cls 
                'Adding namespace'
				
				
				Write-Host ' '
				Write-Host "Time to deploy a namespace this one are available:"
				Write-Host ' '
				#Get-ChildItem -Path _build/azure/ -Name 
				Get-ChildItem -Path _build/azure/ | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}
				Write-Host ' '

				$Json = Read-Host -Prompt 'What namespace do you want to deploy? Input the "Name" and press [ENTER] '
				#Write-Host $Json
				Write-Host ' '

				$msg2 = $Json + ' Is that right? [Y/N]'
				do {
				    $response2 = Read-Host -Prompt $msg2
				    if ($response2 -eq 'n') {
        
						Write-Host ' '
						Write-Host 'We try again..... '
						Write-Host ' '
						#Get-ChildItem -Path _build/azure/ -Name
						Get-ChildItem -Path _build/azure/ | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}
						Write-Host ' '
						$Json = Read-Host -Prompt 'Please enter the "Name" of the namespace you want to use and press [ENTER] '
						Write-Host ' '
						Write-Host $Json
 				   }
				} until ($response -eq 'y')

				Write-Host ' '
				Write-Host 'Deploying.....'
				Write-Host ' '

				$Text = Get-Content -Path ./_build/azure/$Json.json/azure-resources.sh
				$Text.GetType() | Where-Object {$_ -like '*az*'}| Format-Table -AutoSize
				$Text[1] | cmd
				$Text[3] | cmd
				$Text[5] | cmd
				$Text[7] | cmd

				Write-Host ' '
				Write-Host 'Done'
				Write-Host ' '

				# Deploy more namespace in the same cluster?"
				$deploy = 'Do you want to deploy more namespace in the same cluster? [Y/N]'
				do {
				    $response_deploy = Read-Host -Prompt $deploy
 				   if ($response_deploy -eq 'y') {
						Get-ChildItem -Path _build/azure/ | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}
						Write-Host ' '
						$Json = Read-Host -Prompt 'Please enter the "Name" of the namespace you want to use and press [ENTER] '
						Write-Host ' '
						Write-Host $Json
						Write-Host ' '
		
						$msg3 = $Json + ' Is that right? [Y/N]'
							do {
								$response3 = Read-Host -Prompt $msg3

								if ($response3 -eq 'n') {
									Write-Host ' '
									Write-Host 'We try again..... '
									Write-Host ' '
									#Get-ChildItem -Path _build/azure/ -Name
									Get-ChildItem -Path _build/azure/ | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}
									Write-Host ' '
									$Json = Read-Host -Prompt 'Please enter the "Name" of the namespace you want to use and press [ENTER] '
									Write-Host ' '
									#Write-Host $Json
								}
							} until ($response3 -eq 'y')
			
									Write-Host ' '
									Write-Host 'Deploying.....'
									Write-Host ' '

									$Text = Get-Content -Path ./_build/azure/$Json.json/azure-resources.sh
									$Text.GetType() | Where-Object {$_ -like '*az*'}| Format-Table -AutoSize
									$Text[1] | cmd
									$Text[3] | cmd
									$Text[5] | cmd
									$Text[7] | cmd

									Write-Host ' '
									Write-Host 'Done'
									Write-Host ' '
								}	
						} until ($response_deploy -eq 'n')

				Write-Host ' '
				Write-Host 'Done! welcome back...'



				
           } '2' { 
                cls 
                'Adding teams to the project' 
           } '3' { 
                cls 
                'Adding VSTS groups' 
			} '4' { 
                cls 
                'Adding a Git Repository' 
			} '5' { 
                cls 
                'Adding security to groups within the project' 	
			} 'q' { 
                return 
           } 
     } 
     pause 
} 
until ($input -eq 'q') 
