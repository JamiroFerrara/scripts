if ($args[0].count -eq 1){
        $nodes = xml el $args[0] 
        $nodes = $nodes | grep StartOfDuty | ? {$_ -notmatch "SCRCashValue"} | ? {$_ -notmatch "SCRLengthVar"} | ? {$_ -notmatch "SCRSessionNo"}| ? {$_ -notmatch "EODEndMode"} | ? {$_ -notmatch "EODLengthVar"} | ? {$_ -notmatch "EOTTripId"} | ? {$_ -notmatch "EOTRouteCode"} | ? {$_ -notmatch "EOTLengthVar"} | ? {$_ -notmatch "EOTLineCode"} | ? {$_ -notmatch "EODDutyNo"}
        $tDates = get-trans-dates $args[0]

        $chunks = New-Object Collections.Generic.List[string]
        $chunks.Add("")

        $count = 0
        foreach($node in $tDates){
                        $chunks[$count] = $chunks[$count] + $node + " "
                    if ($node.contains("Transaction/StartOfDuty/EODDateTime")){
                        $chunks.Add("")
                        $count++
                    }
                }

        foreach($chunk in $chunks){
                        $dates = $chunk.split(" ") | awk -F "-" '{print $2,$3}'
                        foreach($date in $dates){
                                    if ($date -ne " "){
                                            #FORMAT DATE MM/DD/YYYY
                                        }
                                }
                }
        }
