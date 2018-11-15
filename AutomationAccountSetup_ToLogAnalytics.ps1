#Configuring Automation accounts to Log Analytics workspace


Get-AzureRmResource -ResourceType "Microsoft.Automation/automationAccounts"

Get-AzureRmResource -ResourceType "Microsoft.OperationalInsights/workspaces"


$workspaceId = "/subscriptions/207fd3de-190d-4d79-a1ca-f120efc366a5/resourceGroups/VAMOS/providers/Microsoft.OperationalInsights/workspaces/AzInDiagnosticlogs-ws"
$automationAccountId = "/subscriptions/207fd3de-190d-4d79-a1ca-f120efc366a5/resourceGroups/VAMOS/providers/Microsoft.Automation/automationAccounts/DataHub-Runbook"

Set-AzureRmDiagnosticSetting -ResourceId $automationAccountId -WorkspaceId $workspaceId -Enabled $true

Get-AzureRmDiagnosticSetting -ResourceId $automationAccountId





