$SubscriptionsAcessiveis = az login
$SubscriptionsAcessiveisJson = $SubscriptionsAcessiveis | ConvertFrom-Json
$AppServicePlanListWithTier = @()
foreach($Sub in $SubscriptionsAcessiveisJson){
    az account set --subscription $Sub.id
    [string]$AppServicePlanList = az appservice plan list
    $AppServicePlanListWithoutDuplicateKeys = $AppServicePlanList -creplace "CC", "_CC"
    $AppServicePlanListJson = $AppServicePlanListWithoutDuplicateKeys | ConvertFrom-Json
    foreach($AppServicePlan in $AppServicePlanListJson){
        $AppServicePlanInfo = New-Object PSObject -Property @{
            Name     = $AppServicePlanInfo.name
            Tier             = $AppServicePlanInfo.tier
          }

        $AppServicePlanInfo.name = $AppServicePlan.name
        $AppServicePlanInfo.tier = $AppServicePlan.sku.tier
        $AppServicePlanListWithTier += $AppServicePlanInfo
    }
    
}
$AppServicePlanListWithTier | Export-Csv -Path ".\AppServicePlansWithTier.csv" -NoTypeInformation -Encoding UTF8