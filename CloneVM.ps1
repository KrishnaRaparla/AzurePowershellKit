# Warning , you cant get back this vm agin to work with.

az vm deallocate --resource-group "VAMOS" --name "AzInMongoDBTest"
az vm generalize  --resource-group "VAMOS" --name "AzInMongoDBTest"
az image create  --resource-group "VAMOS" --name "testImage" --source "AzInMongoDBTest"
az vm create --resource-group "VAMOS" --name "TestMachineImage" --image "testImage" --authentication-type "password" --admin-username "amos" --admin-password "amos.amos.123"
az vm show  --resource-group "AMOS" --name "TestMachineImage" --show-details


Get-AzureRmVirtualNetworkGatewayConnection -Name "VAMOS_azure_to_fortisVamos_connection1" -ResourceGroupName "VAMOS"

https://40.86.205.210:8081/healthprobe  



$subscriptionId = "{azure-subscription-id}"
$resourceGroupName = "{resource-group-name}"

# Authenticate to a specific Azure subscription.
Connect-AzureRmAccount -SubscriptionId $subscriptionId

# Password for the service principal
$pwd = "{service-principal-password}"
$secureStringPassword = ConvertTo-SecureString -String $pwd -AsPlainText -Force

# Create a new Azure AD application
$azureAdApplication = New-AzureRmADApplication `
                        -DisplayName "My Azure Monitor" `
                        -HomePage "https://localhost/azure-monitor" `
                        -IdentifierUris "https://localhost/azure-monitor" `
                        -Password $secureStringPassword

# Create a new service principal associated with the designated application
New-AzureRmADServicePrincipal -ApplicationId $azureAdApplication.ApplicationId

# Assign Reader role to the newly created service principal
New-AzureRmRoleAssignment -RoleDefinitionName Reader `
                          -ServicePrincipalName $azureAdApplication.ApplicationId.Guid