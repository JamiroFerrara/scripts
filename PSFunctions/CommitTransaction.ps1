function CommitTransaction {
    param(
        $File
    )

    echo "Committing Transaction.."
    $mpDir = "\\172.20.3.18\d$\MITTSERVER\BATCH\MITTPOPOLA_TRANS_REPAIR\bin"
    $mpExe = $mpDir + "\Mittpopola.exe"
    $mpConfig = $mpDir + "\Mittpopola.exe.config"

    $transCode = $File | xml sel -t -v "Transaction/@cod_acq"
    $cConfig = xml ed -u "(configuration/appSettings/add)[2]/@value" -v $transCode $mpConfig
    $cConfig | out-file $mpConfig

    psexec \\172.20.3.18 $mpExe
}

function GetFileContentAndCommitTransaction {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $file | out-file $wfile
    cat $wfile | out-file $fileDir
    write-host -foregroundcolor green "Done!"

    CommitTransaction -File $file
}

function GetTransactionFilePath {
    param(
        $Path
    )

    $fullname = $Path + "\TRANSACTIONS.xml"
    Write-Output $fullname
}

function GetFileContentFromPath {
    param(
        $Path
    )

    $file = Get-Content $Path
    Write-Output $file
}
