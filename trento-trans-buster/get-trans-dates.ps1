if ($args[0].count -eq 1){

    $nodes = xml el $args[0] 
    $nodes = $nodes | grep StartOfDuty | ? {$_ -notmatch "SCRCashValue"} | ? {$_ -notmatch "SCRLengthVar"} | ? {$_ -notmatch "SCRSessionNo"}| ? {$_ -notmatch "EODEndMode"} | ? {$_ -notmatch "EODLengthVar"} | ? {$_ -notmatch "EOTTripId"} | ? {$_ -notmatch "EOTRouteCode"} | ? {$_ -notmatch "EOTLengthVar"} | ? {$_ -notmatch "EOTLineCode"} | ? {$_ -notmatch "EODDutyNo"}

    $nDuty = xml sel -t -v "count(/Transaction/StartOfDuty)" $args[0] 
    $nSession = xml sel -t -v "count(/Transaction/StartOfDuty/SessionOpening)" $args[0] 
    $nTrip = xml sel -t -v "count(/Transaction/StartOfDuty/StartOfTrip)" $args[0] 

    $iDuty = 0
    $iSession = 0
    $iTrip = 0

    $ieDuty = 0
    $ieSession = 0
    $ieTrip = 0

    foreach($node in $nodes){

            if ($node -eq "Transaction/StartOfDuty"){
                    $iDutyDate = xml sel -t -v "$node/@SODDateTime" $args[0] | Select-Object -Skip $iDuty |Select-Object -first 1 | sed 's/ /-/g'
                    $iDuty++
                    echo "$node-$iDutyDate"
                }
            if ($node -eq "Transaction/StartOfDuty/SessionOpening"){
                    $iSessionDate = xml sel -t -v "$node/@SORDateTime" $args[0] | Select-Object -Skip $iSession |Select-Object -first 1 | sed 's/ /-/g' 
                    $iSession++
                    echo "$node-$iSessionDate"
                }
            if ($node -eq "Transaction/StartOfDuty/StartOfTrip"){
                    $iTripDate = xml sel -t -v "$node/@SOTDateTime" $args[0] | Select-Object -Skip $iTrip |Select-Object -first 1 | sed 's/ /-/g' 
                    $iTrip++
                    echo "$node-$iTripDate"
                }

            if ($node -contains "Transaction/StartOfDuty/StartOfTrip/EOTDateTime"){
                    $ieTripDate = xml sel -t -v $node $args[0] | Select-Object -Skip $ieTrip |Select-Object -first 1 | sed 's/ /-/g' 
                    $ieTrip++
                    echo "$node-$ieTripDate"
                }
            if ($node -contains "Transaction/StartOfDuty/SessionOpening/SCRDateTime"){
                    $ieSessionDate = xml sel -t -v $node $args[0] | Select-Object -Skip $ieSession |Select-Object -first 1 | sed 's/ /-/g' 
                    $ieSession++
                    echo "$node-$ieSessionDate"
                }
            if ($node -eq "Transaction/StartOfDuty/EODDateTime"){
                    $ieDutyDate = xml sel -t -v $node $args[0] | Select-Object -Skip $ieDuty |Select-Object -first 1 | sed 's/ /-/g' 
                    $ieDuty++
                    echo "$node-$ieDutyDate"
                }
        }
    }

