https://docs.microsoft.com/en-us/azure/automation/automation-linux-hrw-install

Hybrid workers set up for windows server

cd "C:\Program Files\Microsoft Monitoring Agent\Agent\AzureAutomation\<version>\HybridRegistration"
Import-Module HybridRegistration.psd1


Add-HybridRunbookWorker –GroupName 'DataHub-Workers' -EndPoint 'https://eus2-agentservice-prod-1.azure-automation.net/accounts/f39ccb94-9e3e-4441-9b4c-f31f482ec4f1' -Token 'Lc3Zrgc/1aX3Sq+H72P3RNUqxa8shUj9sCdRv2FvmL2OEsntQJ966Jk9DbX2qFxl10R59pkME27ASK98SNUrcg=='



Hybrid workers set up for linux server:

wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w <WorkspaceID> -s <WorkspaceKey>


sudo python /opt/microsoft/omsconfig/modules/nxOMSAutomationWorker/DSCResources/MSFT_nxOMSAutomationWorkerResource/automationworker/scripts/onboarding.py --register -w '776fa64c-766a-4296-a74b-48cd6622b939' -k 'Lc3Zrgc/1aX3Sq+H72P3RNUqxa8shUj9sCdRv2FvmL2OEsntQJ966Jk9DbX2qFxl10R59pkME27ASK98SNUrcg==' -g 'DataHub-Workers' -e 'https://eus2-agentservice-prod-1.azure-automation.net/accounts/f39ccb94-9e3e-4441-9b4c-f31f482ec4f1'




ra