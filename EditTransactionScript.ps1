if ($args.count -eq 1){
  $tpath = GetTransactionFilePath -Path $args[0]
  vim $tpath
} 
else {
  write-host -foregroundcolor red "Please provide a transaction file path"
  }
