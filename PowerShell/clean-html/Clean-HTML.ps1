<#
.SYNOPSIS
   Cleans up the HTML export of Typora, the Markdown editor, for use in WordPress.

.Parameter inputfile
   Input file (the Typora export)

.Parameter outputfile
   Output file (to be pasted into the WordPress editor)
#>

param($inputfile, $outputfile)

# Get the entire content as a single string (not as an array of lines)
$content = Get-Content -raw $inputfile

# Remove everything from the beginning to the opening <body> tag
# Note the s modifier: it forces wildcards to match newlines, too
# Note the non-greedy wildcard: .+?
$content = $content -replace '(?s)^.+?<body>', ''

# Remove everything from the closing </body> tag to the end
$content = $content -replace '(?s)</body>.*$', ''

# Open links in a new window and replace single with double quotes
$content = $content -replace '<a href=''([^'']+)''>', '<a href="$1" target="_blank" rel="noopener">'

# Remove ID attributes from headings
$content = $content -replace '<h(\d)\s+id=''[^'']+''>', '<h$1>'

# Code: remove duplicate code syntax highlighting language attributes
$content = $content -replace 'class=''language-([^'']+)''\s+lang=''\1''>', 'class="lang-$1">'

# Code: replace language specifiers
$content = $content -replace '<code class="lang-shell">', '<code class="lang-bash">'
$content = $content -replace '<code class="lang-bat">', '<code class="lang-batch">'

# Replace paragraph tags with newlines
$content = $content -replace '</?p>', "`r`n"

# Replace unnecessary character encodings
$content = $content -replace '&lt;', '<' -replace '&gt;', '>' -replace '&#39;', '''' -replace '&quot;', '"' -replace '&amp;', '&'

# Lists
$content = $content -replace '<ol start=''[^'']*''\s*>', '<ol>'
$content = $content -replace "(`r)?`n(`r)?`n</(o|u)l>", "`r`n</`$3l>`r`n"

# Lists: indent and remove unnecessary closing tag
$content = $content -replace '(?m)^<li>', '   <li>'
$content = $content -replace '</li>', ''

# Table of content
[regex] $pattern = "</h1>"
$content = $pattern.replace($content, "</h1>`r`n`r`n[table-of-content]")
$content += "`r`n`r`n[/table-of-content]"

$content | Out-File $outputfile