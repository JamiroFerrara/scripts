if ($args.count -ne 0)
{
    if ($args.count -eq 1)
    {
        $fileDir = $args[0]
        $wDir = "c:\scripts\trento\trento-trans-buster"
        $tName = "TRANSACTIONS.XML"
        $wFile = "$wDir\$tName"
        $bFile = "$wDir\TRANSACTIONS_ORIGINAL.XML"

        #This is allways true.. for now
        $remSvc = 1

        copy-item $fileDir $wFile
        copy-item $wFile $bFile

        #######################################################################
        #Remove Invalid Chars
        #######################################################################
        echo "Removing Invalid Chars.."

        Repair-XmlString (Get-Content $wFile -Raw) |Set-Content $wFile

        #######################################################################
        #Check for Missing </Transaction> in file ending
        #######################################################################
        #Remove Empty Lines 
        echo "Removing empty lines.."
        (gc $wFile) | ? {$_.trim() -ne "" } | set-content $wFile

        echo "Checking file ending.."
        $lRow = get-content -tail 1 $wFile
        if ($lRow -eq "</Transaction>")
        {
            write-host -foregroundcolor green "File ending correct.."
        }
        else 
        {
            #echo "Last Row --> $lRow"
            write-host -foregroundcolor red "File ending incorrect.. Adding.."
            sed -i '$ d' $wFile
            add-content $wFile "</Transaction>"
            write-host -foregroundcolor yellow "</Transaction> Added!"
        }

        $file = cat $wFile 

        #######################################################################
        #Check for double duties
        #######################################################################
        echo "Checking double duties.."

        $sdCount = $file | grep "<StartOfDuty" | count
        $edCount = $file | grep "</StartOfDuty" | count

        if ($sdCount -ne $edCount)
        {
            write-host -foregroundcolor red "StartOfDuty count != </>"

            $duties = $file | awk '{print NR, $1}' | grep Duty
            $ltr = New-Object Collections.Generic.List[string]

            for($cc = 1; $cc -le $duties.count; $cc++)
            {
                if (($duties[$cc] | awk '{print $2}') -eq ($duties[$cc-1] | awk '{print $2}'))
                {
                    $sIndex = $duties[$cc - 1] | awk '{print $1}'
                    $eIndex = $duties[$cc] | awk '{print $1}'
                    $eIndex = $eIndex -1 

                    $ltr.add("$sindex $eIndex")
                }
            }
        }

        #Build SED string
        $sedLines = ""
        foreach($line in $ltr)
        {
            $split = $line.Split()
            $s = $split[0]
            $e = $split[1]
            
            $sedLines = "$sedLines;$s,$e d"
            write-host -foregroundcolor yellow "Removing lines $s through $e.."
        }

        if ($sedlines -ne "")
        {
            #Delete lines
            $file = $file | sed $sedLines
            $remSVC = 1
        }

        ######################################################################
        #Check for Trip Mismatch
        ######################################################################
        echo "Checking Trip Mismatch.."

        $tripLines = New-Object Collections.Generic.List[string]
        $trlines = $file | awk '$0 ~ /StartOf/ || $0 ~ /SessionOpening/{print NR, $0}'
        for($i = 0; $i -lt $trlines.count; $i++)
        {
            if ($i -ne $trlines.count -1)
            {
                $isClosed = 0
                $currentLine = $trlines[$i]
                $nextLine = $trlines[$i +1]
                if (($currentLine.Split()[1] -eq "<StartOfTrip") -AND ($nextLine.Split()[1] -ne "</StartOfTrip>"))
                {
                    $tripSN = $currentline.split()[0]

                    #Build AWK
                    $awkQ = '$1 >'
                    $awkQ = $awkQ + " $tripSN"
                    $awkQ = $awkQ + '{print $1}'

                    $tripEN = $trlines | grep "</Start" | awk $awkQ
                    $tripEN = $tripEN[0]

                    $tripLines.add("$tripSN $tripEN")
                    write-host -foregroundcolor red "Inconsistent Trip found on line $tripSN. Ending at $tripEN. Removing.."
                }
            }
        }

        #Build SED
        $sedQ = ""
        foreach($v in $tripLines)
        {
            $sLine = $v.split()[0]
            $eLine = $v.split()[1]
            $eLinemin = $eLine - 1

            $sedQ = $sedQ + "$sLine d;$eLine d;$elinemin d;"
        }
        if ($sedQ -ne "")
        {
            $file = $file | sed -e $sedQ
        }

        ######################################################################
        #Remove XXX in file
        ######################################################################
        echo "Removing XXX in file"

        $file = $file -replace '<XXX', '<'
        $file = $file -replace '<XX', '<'
        $file = $file -replace '<X', '<'

        #Save File
        $file | out-file $wFile

        #######################################################################
        #Validation
        #######################################################################
        echo "Validation.."

        $valid = xml val $wFile
        $valid = $valid.split()[2]
        if ($valid -eq "valid")
        {
            $nodes = $file | xml el 
            $nodes = $nodes | grep StartOfDuty | ? {$_ -notmatch "SCRCashValue"} | ? {$_ -notmatch "SCRLengthVar"} | ? {$_ -notmatch "SCRSessionNo"}| ? {$_ -notmatch "EODEndMode"} | ? {$_ -notmatch "EODLengthVar"} | ? {$_ -notmatch "EOTTripId"} | ? {$_ -notmatch "EOTRouteCode"} | ? {$_ -notmatch "EOTLengthVar"} | ? {$_ -notmatch "EOTLineCode"} | ? {$_ -notmatch "EODDutyNo"}

            write-host -foregroundcolor green "Valid!"

            #######################################################################
            #Fix Bus Codes
            #######################################################################
            echo "Replacing Bus Codes.."

            $busCode = $file | xml sel -t -v "Transaction/@Bus"
            $busCode = $busCode.substring(2)
            if ($busCode[0] -eq 0)
            {
                $busCode = $busCode.substring(1)
            }

            echo "Bus Code --> $busCode"

            $CodBusNodes = $file | xml el -a | grep CodBus | grep Matricola | unique
            foreach($node in $CodBusNodes)
            {
                $file = $file | xml ed -u $node -v $busCode 
            }

            echo "Bus Code Fix Done!"

            #######################################################################
            #Concentric Duties
            #######################################################################
            echo "------------------------"
            echo "Removing Concentric Duties.."

            $file = $file | xml ed -d "Transaction/StartOfDuty/SessionOpening/StartOfTrip//StartOfDuty"
            $file = $file | xml ed -d "Transaction/StartOfDuty/SessionOpening//StartOfDuty"
            $file = $file | xml ed -d "Transaction/StartOfDuty//StartOfDuty"

            #######################################################################
            #Get Trans Dates
            #######################################################################
            echo "------------------------"
            echo "Fix Dates.."

            $DDIR = "Transaction//StartOfDuty"
            $values = $file | xml sel -t -v "$DDIR//@*[1] | $DDIR/SessionOpening/SCRDateTime | $DDIR/StartOfTrip/EOTDateTime | $DDIR/EODDateTime | $DDIR/StartOfTrip/EOTDateTime | $DDIR/SessionOpening/StartOfTrip/EOTDateTime"

            $i = 0
            $tDates = New-Object Collections.Generic.List[string]
            foreach($node in $nodes)
            {
                $value = $values[$i]
                $tDates.add("$node-$value")
                $i++
            }

            $chunks = New-Object Collections.Generic.List[string]
            $chunks.Add("")

            $count = 0
            foreach($node in $tDates)
            {
                $chunks[$count] = $chunks[$count] + $node + "`n"
                if ($node.contains("Transaction/StartOfDuty/EODDateTime"))
                {
                    $chunks.Add("")
                    $count++
                }
            }

            #Find disaligned dates
            $results = new-object system.collections.generic.list[string]
            $c = 1
            foreach($chunk in $chunks)
            {
                $dates = $chunk | awk -F "-" '{print $2,$3}'
                $times = $chunk | awk -F "-" '{print $4}'
                $dates = $dates.where({$_ -ne " "})
                $days = $dates | awk -F "/" '{print $1}'
                $months = $dates | awk -F "/" '{print $2}'

                $i = 0
                $dts = New-Object System.Collections.Generic.List[datetime]

                foreach($date in $dates)
                {
                    $format = $months[$i] +  "/" + $days[$i]
                    $date = $date.substring(5)
                    $date = $format + $date
                    $date = [datetime]$date
                    $dts.add($date)

                    $i++
                }

                $dc = $dts.count[0] -1
                $startTime = $dts[0]
                $endTime = $dts[$dc]
                [bool] $bError = $false

                foreach($date in $dts)
                {
                    $ticks = $date.ticks
                    if (($startTime.ticks -le $ticks) -and ($endtime.ticks -ge $ticks))
                    {
                    }
                    else 
                    {
                        [bool] $bError = $true
                    }
                }

                #Finally Edit the file
                if($bError)
                {
                    $startTime = $startTime.Tostring("dd/MM/yyyy hh:mm:ss")
                    write-host -foregroundcolor red "$startTime at index $c"

                    $nodes = $chunk.split() | ? {$_ -ne ""} | awk -F "-" '{print $1}'
                    $dates = $chunk.split() | ? {$_ -ne ""} | awk -F "-" '{print $2, $3}'

                    #Adaptive Method
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/@*[1]" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/*/@*[1]" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/SessionOpening/*/@*[1]" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/StartOfTrip/*/@*[1]" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/StartOfTrip/EOTDateTime" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/SessionOpening/SCRDateTime" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/SessionOpening/StartOfTrip/SOTDateTime" -v $startTime
                    $file = $file | xml ed -u "(Transaction/StartOfDuty)[$c]/EODDateTime" -v $startTime
                    $file | out-file $wFile 

                    $results.add("$($startTime.ticks) $($endTime.ticks)")
                    $remSVC = 1
                }
                else 
                {
                    if ($startTime -ne $null)
                    {
                        $results.add("$($startTime.ticks) $($endTime.ticks)")
                    }
                    write-host -foregroundcolor green "DateTime Correct at index $c"
                }

                $c++
            }

            #######################################################################
            #Check for DateTime alignement
            #######################################################################
            $dIndexes = ""
            for($t = 0; $t -lt $results.count; $t++)
            {
                $time = $results[$t]
                $sTa = $time.split()[0]
                $eTa = $time.split()[1] 

                for($tt = 0; $tt -lt $results.count; $tt++)
                {
                    $sTb = $results[$tt].Split()[0]
                    $eTb = $results[$tt].Split()[1]
                    #echo "Verifing.. $t-$tt"

                    if ($tt -ne $t)
                    {
                        #echo "$sta < $eTb && $eTa > $sTb"
                        if (($sTa -le $eTb) -AND ($sTb -le $eTa))
                        {
                            $dIndexes = $dIndexes + "$t" + "`r`n"
                            $remSVC = 1
                        }
                    }
                }
            }
            

            echo "Datetime Fix Done!"

            #######################################################################
            #Remove SVC's if necessary --> Probably a better fix is needed
            #######################################################################
            if ($remSVC -eq 1)
            {
                $file = $file | sed '/SVC/d'
            }

            $file = $file | sed '/SVCNo/d'

            #######################################################################
            #Print Out File
            #######################################################################

            echo "Printing.."
            $file | out-file $wfile
            cat $wfile | out-file $fileDir
            write-host -foregroundcolor green "Done!"

            #######################################################################
            #Commit Transaction
            #######################################################################
            echo "Committing Transaction.."
            $mpDir = "\\172.20.3.18\d$\MITTSERVER\BATCH\MITTPOPOLA_TRANS_REPAIR\bin"
            $mpExe = $mpDir + "\Mittpopola.exe"
            $mpConfig = $mpDir + "\Mittpopola.exe.config"

            $transCode = $file | xml sel -t -v "Transaction/@cod_acq"
            $cConfig = xml ed -u "(configuration/appSettings/add)[2]/@value" -v $transCode $mpConfig
            $cConfig | out-file $mpConfig

            psexec \\172.20.3.18 $mpExe

            #Invisbile Fix
            Copy-Item $bFile $fileDir
        }
        else 
        {
            #$file | out-file $wfile
            #vim $wfile

            write-host -foregroundcolor red "Invalid!"
            $ex = xml val -e $wFile 2>&1
            echo $ex
        }
    }
}
else 
{
    dl
    gsa
    start-sleep 7
    cat "c:\users\jamiro ferrara\downloads\DirAnnullati.txt" | % {tbus $_}
}
