foreach ($region in "eastus","eastus2","eastus3","centralus","westus2","southerncentralus","northerneurope") {
  Write-Host "=====$region====="
  az vm list-usage --location $region --query "[?limit!='0'].{Name:localName, Current:currentValue, Limit:limit} -o table
}