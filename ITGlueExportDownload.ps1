$base_uri = "https://api.itglue.com"
$api_key = "PleaseEnterYourApiKeyHere"
$destination_path = "PleaseEnterDestinationPathForDownloadedZipHere"

$headers = @{
    "x-api-key" = $api_key
}
# Trim superfluous forward slash from address (if applicable)
if($base_uri[$base_uri.Length-1] -eq "/") {
    $base_uri = $base_uri.Substring(0,$base_uri.Length-1)
}
    
function Get-ITGlueExportByLast {
    $data = @{}
    $resource_uri = "/exports?page[number]=1&sort=-updated-at&page[size]=1"

    try {
        $rest_output = Invoke-RestMethod -Method get -Uri ($base_uri + $resource_uri) -Headers $headers -ContentType application/vnd.api+json
    } catch {
        Write-Error $_
    }

    $data = $rest_output.data
    return $data
}

function Get-ITGlueExportById([uint64]$id) {
    $data = @{}
    $resource_uri = ('/exports/{0}' -f $id)
    
    try {
        $rest_output = Invoke-RestMethod -Method get -Uri ($base_uri + $resource_uri) -Headers $headers -ContentType application/vnd.api+json
    } catch {
        Write-Error $_
    }

    $data = $rest_output.data
    return $data
}

function Get-ITGlueExportZip {
    Param (
        [Parameter(Mandatory = $false)]
        [uint64]$Export_Id
    )
    
    if ($Export_Id) {
        $export_data = Get-ITGlueExportById($Export_Id)
    }
    else {
        $export_data = Get-ITGlueExportByLast
    }

    if ($export_data) {
        $source = $export_data.attributes."download-url"
        $response_id = $export_data."id"

        if ($source) {
            $destination_name = "account.zip"
            if ($export_data.attributes."organization-name") {
                $destination_name = $export_data.attributes."organization-name" + ".zip"
            }

            $destination = Join-Path -Path $destination_path -ChildPath $destination_name 
            
            $start_time = Get-Date
            Invoke-RestMethod -Uri $source -OutFile $destination
            Write-Output "Export no $response_id for $destination_name is downloaded in: $((Get-Date).Subtract($start_time).Seconds) second(s)"
        }
        else {
            Write-Output "The export ID $response_id doesn't contain a downloadable zip."
        }
    }
    else {
        Write-Output "The requested export is not found. Please refer to the error messages"
    }
}