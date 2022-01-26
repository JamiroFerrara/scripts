#Functions
Function search-google {
        $query = 'https://www.google.com/search?q='
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        start "$url"
}
Function search-youtube {
        $query = 'https://www.youtube.com/search?q='
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        start "$url"
}
Function search-lucky {
        $query = 'https://duckduckgo.com/?q=%5C'
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        start "$url"
}

Function Open-GitWeb {
    $r = git remote -v | Select-String -Pattern "(https:\/\/|git@)(?<git>.*)\.git"
    if ($r.Matches.Length -gt 0) {
        $t = "https://" + ($r.Matches[0].Groups |
            Where-Object {$_.Name -eq "git"}).Value.Replace(":", "/")
        Write-Host "gh: openning ",$t,"..." -ForegroundColor "green"
        Start-Process $t
    }
    else
    {
        Write-Host "gh: not a git repository or origin not set correctly." -ForegroundColor "red"
    }
}

filter Get-FileSize {
    "{0:N2} {1}" -f $(
    if ($_ -lt 1kb) { $_, 'Bytes' }
    elseif ($_ -lt 1mb) { ($_/1kb), 'KB' }
    elseif ($_ -lt 1gb) { ($_/1mb), 'MB' }
    elseif ($_ -lt 1tb) { ($_/1gb), 'GB' }
    elseif ($_ -lt 1pb) { ($_/1tb), 'TB' }
    else { ($_/1pb), 'PB' }
    )
}

#Function Get-ESSearchResult {
#    [CmdletBinding()]
#    [Alias("s")]
#    Param
#    (
#        #searchterm
#        [Parameter(Mandatory=$true, Position=0)]
#        $SearchTerm,
#        #openitem
#        [switch]$OpenItem,
#        [switch]$CopyFullPath,
#        [switch]$OpenFolder,
#        [switch]$AsObject
#    )
#    $esPath = 'C:\Program Files*\es\es.exe'
#    if (!(Test-Path (Resolve-Path $esPath).Path)){
#        Write-Warning "Everything commandline es.exe could not be found on the system please download and install via http://www.voidtools.com/es.zip"
#    }
#    $result = & (Resolve-Path $esPath).Path $(Get-Location) $SearchTerm
#    $result | fzf --height 50% --reverse | ii
#}

Function Get-ESGlobalSearchResult {
    [CmdletBinding()]
    [Alias("gs")]
    Param
    (
        #searchterm
        [Parameter(Mandatory=$true, Position=0)]
        $SearchTerm,
        #openitem
        [switch]$OpenItem,
        [switch]$CopyFullPath,
        [switch]$OpenFolder,
        [switch]$AsObject
    )
    $esPath = 'C:\Program Files*\es\es.exe'
    if (!(Test-Path (Resolve-Path $esPath).Path)){
        Write-Warning "Everything commandline es.exe could not be found on the system please download and install via http://www.voidtools.com/es.zip"
    }
    $result = & (Resolve-Path $esPath).Path /a-d $SearchTerm | ? {$_ -notmatch '.manifest'} | ? {$_ -notmatch '.dll'}| ? {$_ -notmatch '.service'} | ? {$_ -notmatch '.timer'} | ? {$_ -notmatch '.dsh'} | ? {$_ -notmatch '.cpp'} | ? {$_ -notmatch '.py'}
    $result | fzf --height 50% --reverse | ii
}

Function Open-ESSearchResult {
    [CmdletBinding()]
    [Alias("or")]
    Param
    (
        #searchterm
        [Parameter(Mandatory=$true, Position=0)]
        $SearchTerm,
        #openitem
        [switch]$OpenItem,
        [switch]$CopyFullPath,
        [switch]$OpenFolder,
        [switch]$AsObject
    )
    $esPath = 'C:\Program Files*\es\es.exe'
    if (!(Test-Path (Resolve-Path $esPath).Path)){
        Write-Warning "Everything commandline es.exe could not be found on the system please download and install via http://www.voidtools.com/es.zip"
    }
    $result = & (Resolve-Path $esPath).Path /a-d $(Get-Location) $SearchTerm
    ii $result
}

function Get-WifiNetwork {
 end {
  netsh wlan sh net mode=bssid | % -process {
    if ($_ -match '^SSID (\d+) : (.*)$') {
        $current = @{}
        $networks += $current
        $current.Index = $matches[1].trim()
        $current.SSID = $matches[2].trim()
    } else {
        if ($_ -match '^\s+(.*)\s+:\s+(.*)\s*$') {
            $current[$matches[1].trim()] = $matches[2].trim()
        }
    }
  } -begin { $networks = @() } -end { $networks|% { new-object psobject -property $_ } }
 }
}
