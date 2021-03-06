<#
.SYNOPSIS
	Lists the latest news
.DESCRIPTION
	This script lists the latest RSS feed news.
.PARAMETER RSS_URL
	Specifies the URL to the RSS feed
.PARAMETER MaxCount
	Specifies the number of news to list
.EXAMPLE
	PS> ./list-news
.NOTES
	Author: Markus Fleschutz ยท License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RSS_URL = "https://yahoo.com/news/rss/world", [int]$MaxCount = 20)

try {
	[xml]$Content = (invoke-webRequest -uri $RSS_URL -useBasicParsing).Content
	"`n๐ $($Content.rss.channel.title) ๐"

	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"โ $($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
	exit 0 # success
} catch {
	"โ ๏ธ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
