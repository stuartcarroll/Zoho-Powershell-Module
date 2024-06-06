<#
.Synopsis
   Authenticate to Zoho API using Self Client
.DESCRIPTION
   Authenticate to Zoho API using Self Client. 

   This works by taking a Client ID, Client Secret and Generated Code and posting them to Zoho to receive a Auth Code
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZohoCRMv6Auth {
    param (
        [string]$protocol = "https://",
        [string]$apidomain = "accounts.zoho.eu",
        [string]$AuthPath = "/oauth/v2/token",

        #Type of request 
        [Parameter(Mandatory=$true)]
        [ValidateSet("Auth","Refresh")]
        [string]$RequestType = "Auth",
        
        #Self Client Settings from https://api-console.zoho.eu/
        [Parameter(Mandatory=$true)]
        [string]$ClientID,
        [Parameter(Mandatory=$true)]
        [string]$ClientSec,
        [Parameter(Mandatory=$true)]
        [string]$Code,

        #Output request info:
        [string]$info = $false
    )

    $Method = "Post"
    $AccessTokenURL = $protocol+$apidomain+$AuthPath


        # Authetnication request or refresh request 
        Switch ($RequestType)
        {
            Auth    {
                $Body = @{
                    'client_id' = $ClientID
                    'client_secret' = $ClientSec
                    'grant_type' = "authorization_code"
                    'code' = $Code
                }
            }
            Refresh {
                $Body = @{
                    'client_id' = $ClientID
                    'client_secret' = $ClientSec
                    'grant_type' = "refresh_token"
                    'refresh_token' = $Code
                }
                
            }
        }




    #Give Info Pre Request
    if($info -eq $true)
        {
            Write-Host Request: -ForegroundColor Yellow
            Write-Host $Method $AccessTokenURL -ForegroundColor Green
        }

    #Auth Request
    $Result = Invoke-RestMethod -uri $AccessTokenURL -Method $Method -Body $Body  #-ContentType 'multipart/form-data'
    
    #Give Info Post Request
    if($info -eq $true)
        {
            Write-Host "Response: " -ForegroundColor Yellow

            if($Result.error)
                {
                Write-Host $Result.error -ForegroundColor Red  
                }
            
            if($Result.access_token)
                {
                Write-Host -ForegroundColor Green "Access Token: "$Result.access_token
                Write-Host -ForegroundColor Green "Refresh Token: "$Result.refresh_token
                Write-Host -ForegroundColor Green "Scope: "$Result.api_domain
                Write-Host -ForegroundColor Green "Scope: "$Result.token_type
                Write-Host -ForegroundColor Green "Expires in: "$Result.expires_in
                }
        }
    
    return $Result
}


<#
.Synopsis
   Send request to Zoho API 
.DESCRIPTION
   Send request to Zoho API 
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZohoCRMv6Record {
    param (
        [string]$protocol = "https://",
        [string]$apidomain = "www.zohoapis.eu",

 
        [Parameter(Mandatory=$true)]
        [string]$module = "Leads",
        [Parameter(Mandatory=$true)]
        [string]$Code,
        [string]$fields,

        #Output request info:
        [string]$info = $false
    )

    $Method = "get"
    $crmpath = "/crm/v6/"
    $url = $protocol+$apidomain+$crmpath+$module+$fields

    $auth = "Zoho-oauthtoken "+$Code
    
    $headers = @{
        'Authorization' = $auth
    }

       #Give Info Pre Request
       if($info -eq $true)
       {
           Write-Host Request: -ForegroundColor Yellow
           Write-Host $Method $url -ForegroundColor Green
       }
   

    $Result = Invoke-RestMethod -Method $Method -uri $url -Headers $headers

    #Give Info Pre Request
    if($info -eq $true)
        {
            Write-Host Request: -ForegroundColor Yellow
            Write-Host $Method $url -ForegroundColor Green
        }
    
    return $Result.data
}

<#
.Synopsis
   Send request to Zoho API 
.DESCRIPTION
   Send request to Zoho API 
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function New-ZohoCRMv6Record {
    param (
        [string]$protocol = "https://",
        [string]$apidomain = "www.zohoapis.eu",
        [Parameter(Mandatory=$true)]
        [string]$module = "Leads",
        [Parameter(Mandatory=$true)]
        [string]$Code,
        [Parameter(Mandatory=$true)]
        [string]$json,
        [string]$info = $false
    )

    $Method = "post"
    $crmpath = "/crm/v6/"


        $url = $protocol+$apidomain+$crmpath+$module


    $auth = "Zoho-oauthtoken "+$Code
    
    $headers = @{
        'Authorization' = $auth
    }

       #Give Info Pre Request
       if($info -eq $true)
       {
           Write-Host Request: -ForegroundColor Yellow
           Write-Host $Method $url -ForegroundColor Green
           write-host $json -ForegroundColor Green
       }
   

    $Result = Invoke-RestMethod -Method $Method -uri $url -Headers $headers -Body $json

    #Give Info Pre Request
    if($info -eq $true)
        {
            Write-Host Request: -ForegroundColor Yellow
            Write-Host $Method $url -ForegroundColor Green
        }
    
    return $Result.data
}


<#
.Synopsis
   Send request to Zoho API 
.DESCRIPTION
   Send request to Zoho API 
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Set-ZohoCRMv6Record {
    param (
        [string]$protocol = "https://",
        [string]$apidomain = "www.zohoapis.eu",
        [Parameter(Mandatory=$true)]
        [string]$module = "Leads",
        [Parameter(Mandatory=$true)]
        [string]$Code,
        [Parameter(Mandatory=$true)]
        [string]$json,
        [string]$recordid,
        [string]$info = $false
    )

    $Method = "put"
    $crmpath = "/crm/v6/"

    if($recordid){
        $url = $protocol+$apidomain+$crmpath+$module+"/"+$recordid
    }else{
        $url = $protocol+$apidomain+$crmpath+$module
    }

    $auth = "Zoho-oauthtoken "+$Code
    
    $headers = @{
        'Authorization' = $auth
    }

       #Give Info Pre Request
       if($info -eq $true)
       {
           Write-Host Request: -ForegroundColor Yellow
           Write-Host $Method $url -ForegroundColor Green
       }
   

    $Result = Invoke-RestMethod -Method $Method -uri $url -Headers $headers -Body $json

    #Give Info Pre Request
    if($info -eq $true)
        {
            Write-Host Request: -ForegroundColor Yellow
            Write-Host $Method $url -ForegroundColor Green
        }
    
    return $Result.data
}

<#
.Synopsis
   Send request to Zoho Desk API 
.DESCRIPTION
   Send request to Zoho API 
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZohoDeskRecord {
    param (
        [string]$protocol = "https://",
        [string]$apidomain = "desk.zoho.eu",

 
        [Parameter(Mandatory=$true)]
        [string]$module = "tickets",
        [Parameter(Mandatory=$true)]
        [string]$orgid = "20068101374",
        [Parameter(Mandatory=$true)]
        [string]$Code,
        [string]$query,

        #Output request info:
        [string]$info = $false
    )

    $Method = "get"
    $crmpath = "/api/v1/"
    $q = "?"
    $url = $protocol+$apidomain+$crmpath+$module+$q+$query

    $auth = "Zoho-oauthtoken "+$Code
    
    $headers = @{
        'Authorization' = $auth
    }

       #Give Info Pre Request
       if($info -eq $true)
       {
           Write-Host Request: -ForegroundColor Yellow
           Write-Host $Method $url -ForegroundColor Green
       }
   

    $Result = Invoke-RestMethod -Method $Method -uri $url -Headers $headers

    #Give Info Pre Request
    if($info -eq $true)
        {
            Write-Host Request: -ForegroundColor Yellow
            Write-Host $Method $url -ForegroundColor Green
        }
    
    return $Result.data
}
