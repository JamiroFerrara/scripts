if ($args.count -eq 0)
{
    $files = ls | %{$_.FullName}
    foreach($file in $files)
    {
        try
        {
            $ext = $file.substring($file.length-4)
            $outFile = $file.substring(0, $file.length-4)
            $outFile = "$outfile Normalized$ext"
            sox --norm $file $outFile
            echo $file
            echo $outfile

            echo "Normalized!"
            Start-Sleep -seconds 1
        }
        catch
        {
            echo "Failed!"
        }
    }
}
