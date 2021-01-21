$resourceGroupName = $null
$appServicePlanName = $null

Write-Host "Login na conta do PortalAzure"
az login

$ExisteResourceGroup = Read-Host "Ja possui Resource Group? S ou N"

if($ExisteResourceGroup -eq "S"){
    $resourceGroupName = Read-Host "Nome do Resource Group"

    $ExisteAppServicePlan = Read-Host "Ja possui App Service Plan? S ou N"
    if($ExisteAppServicePlan -eq "S"){
        $appServicePlanName = Read-Host "Nome do App Service Plan"
    }
    else{
        Write-Host "Criacao do App Service Plan"
        [string]$appServicePlanName = Read-Host "Nome do App Service Plan:"
        [string]$sku = Read-Host "SKU pretendido:"
        az appservice plan create --name $appServicePlanName --resource-group $resourceGroupName --sku $sku
    }
}
else{
Write-Host "Criacao do Resource Group"
#"brazilsouth     "ApresentacaoTrainee""
[string]$location = Read-Host "Location do Resource Group:"
[string]$resourceGroupName = Read-Host "Nome do Resource Group:"
az group create --location $location --name $resourceGroupName

Write-Host "Criacao do App Service Plan"
[string]$appServicePlanName = Read-Host "Nome do App Service Plan:"
[string]$sku = Read-Host "SKU pretendido:"
az appservice plan create --name $appServicePlanName --resource-group $resourceGroupName --sku $sku
}


Write-Host "Criacao do WebApp"
[string]$webAppName = Read-Host "Nome do WebApp:"
az webapp create --name $webAppName --resource-group $resourceGroupName --plan $appServicePlanName

Write-Host "Fim do Script"