<#
 # This is an example Runbook to try out in your Automation Account containing the new ARM modules
 #>

<#
 #  The following three lines retrieve Automation Assets which you will need to create/upload to your Automation Account:
 #    $SPAppID: the application ID of your service principal
 #    $SPTenant: the AD tenant in which your service principal exists
 #    $Certificate: the .pfx certificate created for your service principal
 #    (see CreateCertAndServicePrincipal.ps1)
 #>
$SPAppID = Get-AutomationVariable -Name 'SPCertAppID'
$SPTenant = Get-AutomationVariable -Name 'SPCertTenant'
$Certificate = Get-AutomationCertificate -Name "ServicePrincipalCert"
$CertThumbprint = ($Certificate.Thumbprint).ToString()    
    
<#
 #  NOTE: this if statement will ALWAYS return true, given our current sandbox implementation:
 #    Certificate Assets uploaded by the user are placed in Cert:\LocalMachine\Root when the sandbox is created.
 #    However, for the Login-AzureRmAccount cmdlet to work, it must be given a certificate that is stored in
 #      Cert:\CurrentUser\My or Cert:\LocalMachine\My. So, the following code puts the cert there.
 #    This is very ugly right now, but will be fixed in an upcoming Automation release. 
 #>        
if ((Test-Path Cert:\CurrentUser\My\$CertThumbprint) -eq $false)
{
	"Installing the Service Principal's certificate..."
    $store = new-object System.Security.Cryptography.X509Certificates.X509Store("My", "CurrentUser") 
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    $store.Add($Certificate) 
    $store.Close() 
}

<#
 #
 # Now the actual work begins
 #
 #>

"Logging in to Azure..."

Login-AzureRmAccount -ServicePrincipal -TenantId $SPTenant -CertificateThumbprint $CertThumbprint -ApplicationId $SPAppID 

"Selecting Azure subscription..."

Select-AzureRmSubscription -SubscriptionId '<YOUR SUBSCRIPTION ID>' -TenantId $SPTenant

"Getting the VMs in this subscription, for demonstration purposes..."
Get-AzureRmVm
""
"Done."
