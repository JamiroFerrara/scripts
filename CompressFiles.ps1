if ($args.Count -eq 0)
{
    $compress = @{
    Path = "./*"
    CompressionLevel = "Fastest"
    DestinationPath = "./CompressedFiles"
            }
    Compress-Archive @compress
}
else 
{
    $compress = @{
    Path = "./*"
    CompressionLevel = "Fastest"
    DestinationPath = "./$($args[0])"
     }
    Compress-Archive @compress
}

