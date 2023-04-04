# ITGlueExportDownload ReadMe

Credits to the Original Creator: Jing Hu - Back End Developer - IT Glue

You can use our complimentary export download script to get a jump start on downloading your IT Glue export via the API.

Existing IT Glue Documentation related to our exports via the API can be found here at:

[Helpdesk | Exporting and Backing up Account Data]<https://helpdesk.kaseya.com/hc/en-gb/articles/4407476851985-Exporting-and-backing-up-account-data>
[Helpdesk | Getting Started with the ITGLUE API]<https://helpdesk.kaseya.com/hc/en-gb/articles/4407484149265-Getting-started-with-the-IT-Glue-API>
[API Reference | Exports]<https://api.itglue.com/developer/#exports>

The script ITGlueExportDownload.ps1 include 3 functions:

* Get-ITGlueExportZip
* Get-ITGlueExportById([int]$id)
* Get-ITGlueExportByLast.

This script also contains several global variables that can be used in all functions.
The base URI and API key need to be configured first to talk with ITGlue server, and a destination folder path also needs to be defined to save the zip attachment.

These fields are simply hard-coded on the top of the script:

```powershell
$base_uri = "https://api.itglue.com" replace with custom domain
$api_key = "PleaseEnterYourApiKeyHere" replace with custom Api Key
$destination_path = "PleaseEnterDestinationPathForDownloadedZipHere" replace with custom destination folder path
```

In PowerShell it is very simple to run the script, for an example:

```powershell
PS /Users/jinghu>  . ./Documents/powershell/ITGlueExportDownload.ps1
```

## Run PowerShell Function

A function in PowerShell is a grouping of code that has an optional input and output. It's a way of collecting up a bunch of code to perform one or many different times by just pointing to it instead of duplicating that code repeatedly.

3 functions in ITGlueExportDownload.ps1:

`Get-ITGlueExportZip` main function that can accept an optional param Export_Id and automatically download the zip attachment if available;
`Get-ITGlueExportById([int]$id)` supportive function to send rest request for the export with specified id;
`Get-ITGlueExportByLast` supportive function to send rest request for the most recently updated export under the account of input API key.

We only need to call the main function which will then call a supportive function to send the corresponding rest request for the export. The main function can be called with/without param. Only `Get-ITGlueExportZip` should be exposed to the user, please don’t call the other two functions.

Without param the most recently updated export under the account is retrieved. This export with id 1305 doesn't contain a downloadable url.

```powershell
PS /Users/jinghu> Get-ITGlueExportZip
The export ID 1305 doesn't contain a downloadable zip.
```

With param -Export_Id 1303 the specified export with id 1303 under the account is retrieved. This export contains a downloadable url so that a download will be triggered automatically and finished in 1 second.

```powershell
PS /Users/jinghu> Get-ITGlueExportZip -Export_Id 1303
Export no 1303 for Import Org 20003 is downloaded in: 1 second(s)
```

Exception cases

* Wrong api_key
* Wrong destination_path
* Wrong base_uri
* Invalid Export_Id

Run in Command Prompt

On PC we can also run the PowerShell script in Command Prompt instead of open a PowerShell terminal:

```powershell
powershell -command "& { .  ./Documents/powershell/ITGlueExportDownload.ps1; Get-ITGlueExportZip }"
powershell -command "& { .  ./Documents/powershell/ITGlueExportDownload.ps1; Get-ITGlueExportZip -Export_Id 1303 }"
```

## Disclaimer

The information provided here by IT Glue is for general informational purposes only. All information is provided in good faith, however we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability or completeness of any information provided here.

Under no circumstance shall we have any liability to you for any loss or damage of any kind incurred as a result of the use of the information provided here. Your use of the information here is solely at your own risk. This disclaimer was created using Termly’s Disclaimer Generator.
