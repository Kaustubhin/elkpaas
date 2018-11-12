$rg="KO002"

New-AzureRmResourceGroup -Name $rg -Location "Central US"

Write-Host "Enter the Username and Password for VM"

New-AzureRmResourceGroupDeployment -ResourceGroupName $rg `
-TemplateFile "https://raw.githubusercontent.com/Kaustubhin/elkpaas/master/elastickkibana.json"


# Add Custom extension to Install Elk-Stack on VM1 
Set-AzureRmVMCustomScriptExtension -ResourceGroupName $rg `
     -VMName EK01 `
     -Location "Central US" `
     -FileUri "https://raw.githubusercontent.com/Kaustubhin/elkpaas/master/elkinstall.ps1" `
     -Run 'elkinstall.ps1' `
     -Name InstallEK-Stack
Start-Sleep -Seconds 180


<##Add Custom extension to Install Winlogbeat on VM2
Set-AzureRmVMCustomScriptExtension -ResourceGroupName $rg `
     -VMName elkVM1 `
     -Location "Central US" `
     -FileUri "https://raw.githubusercontent.com/Kaustubhin/elkpaas/master/winlogbeatinstall.ps1" `
     -Run 'winlogbeatinstall.ps1' `
     -Name Winlogbeatinstall
Start-Sleep -Seconds 60#>
