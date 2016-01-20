Param(
  [Parameter(Mandatory=$false)]
  [string]$username	
)

function Move-DisabledUserFolder ($username){

#This sets the variable that determines if the user is active
$is_active = Get-ADUser $username | select -expandproperty enabled

#checks to make sure the user is active, no point doing anything if the account is still active
if ($is_active -eq $False) {

    #Stores the location of the users folder
    $user_folder = Get-ADUSer -Identity "$username" -Properties homeDirectory | Select-Object -ExpandProperty homeDirectory
    
    #Archive folder to store old user profiles
    $disabled_folder = ""

    #Tests to see if the path is null
    if (!$user_folder){

        Write-Host "There is no profile assigned to $username" -ForegroundColor Yellow
        
        }
    #if the path isn't active, notify the script runner
    elseif(!(Test-Path $user_folder)){
    
        Write-Host "It appears the path to the folder is not available, $username's home directory value was '$user_folder' " -ForegroundColor Yellow
    
        }

    #tests to see if the path is available
    elseif(Test-Path $user_folder){
        
        #moves the folder to the disabled user folder
        Move-Item $user_folder $disabled_folder -force

        Write-Host "$username's profile ($user_folder) has been moved to $disabled_folder" -ForegroundColor Cyan
    
    }
    
}
#if the account is active, notify the script runner    
elseif ($is_active -eq $True){
        
        Write-Host "It appears $username's account is still active, please deactivate the account and run the command again"
    
    }

}