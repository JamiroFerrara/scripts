if ($args.count -ne 0)
{
    $query = ""

    if ($args.count -eq 1)
    {
        $query = $args[0]
    }
    else 
    {
        foreach($arg in $args)
        {
            $query = $query + " " + $arg
        }
    }

    $body = (get-content 'c:\scripts\open-ai\alexa.json' -raw | % {$_.replace("xxxx", $query)} | ConvertFrom-Json) | ConvertTo-Json
    $headers = @{
    'Authorization' = 'Bearer ' + $token
    'Content-Type' = 'application/json'
    }

    $response = Invoke-RestMethod -Method 'Post' -Uri https://api.openai.com/v1/engines/text-davinci-001/completions  `
    -Headers $headers `
    -Body $body

    $response = $response

    echo "-----------------"
    echo $query
    echo $response.choices.text
    echo "-----------------"
}
