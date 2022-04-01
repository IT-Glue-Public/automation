Readme

Credits to the Original Creator: Jing Hu - Back End Developer - IT Glue

The script ITGlueExportDownload.ps1 include 3 functions: 
Get-ITGlueExportZip
Get-ITGlueExportById([int]$id)
Get-ITGlueExportByLast.

This script also contains several global variables that can be used in all functions. The base URI and API key need to be configured first to talk with ITGlue server, and a destination folder path also needs to be defined to save the zip attachment. These fields are simply hard-coded on the top of the script.
$base_uri = "https://api.itglue.com" replace with custom domain
$api_key = "PleaseEnterYourApiKeyHere" replace with custom Api Key
$destination_path = "PleaseEnterDestinationPathForDownloadedZipHere" replace with custom destination folder path

In PowerShell it is very simple to run a script, for example:
PS /Users/jinghu>  . ./Documents/powershell/ITGlueExportDownload.ps1

Run PowerShell Function
A function in PowerShell is a grouping of code that has an optional input and output. It's a way of collecting up a bunch of code to perform one or many different times by just pointing to it instead of duplicating that code repeatedly.

3 functions in ITGlueExportDownload.ps1:
Get-ITGlueExportZip main function that can accept an optional param Export_Id and automatically download the zip attachment if available;
Get-ITGlueExportById([int]$id) supportive function to send rest request for the export with specified id;
Get-ITGlueExportByLast supportive function to send rest request for the most recently updated export under the account of input API key.

We only need to call the main function which will then call a supportive function to send the corresponding rest request for the export. The main function can be called with/without param. Only Get-ITGlueExportZip should be exposed to the user, please don’t call the other two functions.

Without param the most recently updated export under the account is retrieved. This export with id 1305 doesn't contain a downloadable url.
PS /Users/jinghu> Get-ITGlueExportZip
The export ID 1305 doesn't contain a downloadable zip.

With param -Export_Id 1303 the specified export with id 1303 under the account is retrieved. This export contains a downloadable url so that a download will be triggered automatically and finished in 1 second.
PS /Users/jinghu> Get-ITGlueExportZip -Export_Id 1303
Export no 1303 for Import Org 20003 is downloaded in: 1 second(s)

Exception cases

Wrong api_key
Wrong destination_path
Wrong base_uri
Invalid Export_Id


Run in Command Prompt

On PC we can also run the PowerShell script in Command Prompt instead of open a PowerShell terminal:
powershell -command "& { .  ./Documents/powershell/ITGlueExportDownload.ps1; Get-ITGlueExportZip }"
powershell -command "& { .  ./Documents/powershell/ITGlueExportDownload.ps1; Get-ITGlueExportZip -Export_Id 1303 }"
