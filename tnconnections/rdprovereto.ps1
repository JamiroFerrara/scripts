# Create credentials
cmdkey /generic:"172.29.119.10" /user:"MITTRENTO\ITE1544" /pass:"Trento30"
# Connect MSTSC with servername and credentials created before
mstsc /v:172.29.119.10
# Delete the credentials after MSTSC session is done
cmdkey /delete:TERMSRV/172.29.119.10
