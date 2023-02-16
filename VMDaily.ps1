param([string]$location)
$tstamp = Get-Date -Format "ddMMyyyyhh"
Write-Host "Creating a temporary resource group for VMs"
New-AzResourceGroup -name ('temp-rg-' + $tstamp) -location $location
$resourceGroup = ('temp-rg-' + $tstamp)
Write-Host "Resource group" $resourceGroup "created and mounted"
$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."
For ($i = 1; $i -le 3; $i++) {
    $vmName = "temp-vm-" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -size standard_d2s_v3 -location $location -image microsoftwindowsdesktop:windows-10:win10-21h2-pro:latest -openport 22 -credential $adminCredential
}