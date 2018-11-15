
[OutputType("PSAzureOperationResponse")]

    param
    (
        [Parameter (Mandatory=$false)]
        [object] $WebhookData

    )
   
$ErrorActionPreference = "stop"

# Parsing the payload 
# $WebhookData object has the following propoerties WebhookName, RequestHeader and RequestBody.
if ($WebhookData)
{
    # Get the data object from WebhookData.
    $WebhookBody = (ConvertFrom-Json -InputObject $WebhookData.RequestBody)

    # Get the info needed to identify the incident (depends on the payload schema).
    $schemaId = $WebhookBody.schemaId
    Write-Verbose "schemaId: $schemaId" -Verbose
    if ($schemaId -eq "NewrelicMetricAlert") {
        # parsing the payload information
        $AlertContext = [object] ($WebhookBody.data).context
        $Incident_id = $AlertContext.incident_id
        $Incident_url= $AlertCOntext.incident_url
        $application_name = $AlertContext.application_name
        $event_type = $AlertContext.event_type # <-- Always "INCIDENT"
        $targets = $AlertContext.targets
        #$severity = $AlertContext.severity #<-- [INFO|WARN|CRITICAL]
        $condition_id = $AlertContext.condition_id
        $condition_name = $AlertContext.condition_name
        $action = $AlertContext.action #<-- An URL to Confluence to explain what to do
        $account_name = $AlertContext.account_name #<-- Always "DIP-Prod"
        $current_state = $AlertContext.current_state #<-- [open|acknowledged|closed]
        $details = $AlertContext.details
        $duration = $AlertContext.duration
        $timestamp = $AlertContext.timestamp
        $severity = ($WebhookBody.data).severity #<-- [INFO|WARN|CRITICAL] 

        Write-Output $Requestbody
    }
    
    else {
        # The schema isn't supported.
        Write-Error "The alert data schema - $schemaId - is not supported."
    }
    
}
else {
    # Error
    Write-Error "This runbook is meant to be started from an Azure alert webhook only."
}