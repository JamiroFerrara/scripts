if ($args.count -eq 1){
  $tpath = GetTransactionFilePath -Path $args[0]
} 

if ($tpath -eq $null){
  Write-Error "No transaction file found"
  exit 1
}

$fileContent = GetFileContentFromPath -Path $tpath
CommitTransaction -File $fileContent
write-host -foregroundcolor green "Transaction committed successfully!"
