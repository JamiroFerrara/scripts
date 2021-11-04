cd 'C:\Scripts\appdownloads'
ls | where {$_ -notmatch 'initall.ps1'} | ii