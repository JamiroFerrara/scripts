     # Create credentials
     cmdkey /generic:"172.20.3.147" /user:"MITTRENTO\ITE1544" /pass:"Trento32"
     # Connect MSTSC with servername and credentials created before
     mstsc /v:172.20.3.147
     # Delete the credentials after MSTSC session is done
     cmdkey /delete:TERMSRV/172.20.3.147
