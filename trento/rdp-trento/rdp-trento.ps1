$dirs = cat "C:\Scripts\trento\rdp-trento\ip-list"
$sText = $dirs | fzf --height 50% --reverse
$output = $sText|%{$_.split('"')[1]}

# Create credentials
cmdkey /generic:"output" /user:"MITTRENTO\ITE1544" /pass:"Trento32"
# Connect MSTSC with servername and credentials created before
mstsc /v:$output
# Delete the credentials after MSTSC session is done
cmdkey /delete:TERMSRV/$output
