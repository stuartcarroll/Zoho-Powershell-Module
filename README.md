# Zoho-Powershell-Module

Name
Zoho CRMv6 Powershell functions

Description
The following Powershell functions have been created to enable Zoho API authetnication, currently by Self Client API, and reading (get), creating (post) and modifying (put) Zoho CRM records.

These functions use version 6 of the Zoho CRM API:

Get-ZohoCRMv6Auth – To authenticate to Zoho API using “Self Client” application type.
Get-ZohoCRMv6Record – To get (read) a record or records from Zoho CRM
New-ZohoCRMv6Record – To post (create) records in Zoho CRM
Set-ZohoCRMv6Record – To put (modify) records in Zoho CRM

These functions use version 1 of the Zoho Desk API:

Get-ZohoDeskRecord To get (read) a record or records from Zoho Desk

Getting started
Get-ZohoCRMv6Auth needs to be run to obtain an access token prior to running any of the other functions.
Our Org ID is: 20068101374

Get-ZohoCRMv6Auth – To authenticate to Zoho API using “Self Client” application type.
API keys are created in the Zoho API Console - https://api-console.zoho.eu/

Creating Self Client application in Zoho API Console
Screenshot are available in readme.docx

Log into https://api-console.zoho.eu/

Click “Add Client”
From “Client Types”, Select “Create Now” from the “Self Client” field

Self Client: Stand-alone applications that perform only back-end jobs (without any manual intervention) like data sync.

Select “Create” when prompted for the client type (Self Client)
Select “ok” when prompted to enable self-client
Record the “Client ID” and “Client Secret” values created
Select ‘”Generate Code”
Enter your required scope – In this instance we are using “ZohoCRM.modules.ALL”
Select “10 minutes” from the “Time Duration” drop down menu - This will dictate how long your access token will last.4.
Enter a brief description of the task you're completing in the “Scope Description” field
Enter anything in the “Scope Description” field


Generating a self-client code

Log into https://api-console.zoho.eu/

Select ‘”Generate Code”
Enter your required scope (Example: “ZohoCRM.modules.ALL”)
Select “10 minutes” from the “Time Duration” drop down menu - This will dictate how long your access token will last.4.
Enter a brief description of the task you're completing in the “Scope Description” field


Using Get-ZohoCRMv6Auth

Set a $clientID variable using the client ID from your self client application created in the API console
Set a $clientSec variable using the client Secret from your self client application created in the API console

$a = Get-ZohoCRMv6Auth -info $true -ClientID $clientID -ClientSec $clientSec -RequestType Auth -Code 
Supporting documentation from Zoho:
Overview: https://www.zoho.com/crm/developer/docs/api/v6/oauth-overview.html
Registering a client: https://www.zoho.com/crm/developer/docs/api/v6/register-client.html

Get-ZohoCRMv6Record – To get (read) a record or records from Zoho CRM
https://www.zoho.com/crm/developer/docs/api/v6/get-records.html

New-ZohoCRMv6Record – To post (create) records in Zoho CRM
https://www.zoho.com/crm/developer/docs/api/v6/insert-records.html

Set-ZohoCRMv6Record – To put (modify) records in Zoho CRM
https://www.zoho.com/crm/developer/docs/api/v6/update-records.html

Get-ZohoDeskRecord
https://desk.zoho.com/DeskAPIDocument#Introduction

Roadmap

Complete README documentation.
Complete Help section for each function
Modify post & put to encapsulate json payloads passed to them in the 'Data' array required by Zoho (Currently this must be done piror to passing the json payload to the function.)
Delete record function
Search records function (currently in get function but should be split out)
Upsert record function
Allow for refresh of access token in Authetnication function
Explore authetnication using "web" method
