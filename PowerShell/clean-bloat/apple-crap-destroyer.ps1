# powershell script for deleting unwanted apple crap files – mostly on "infected" USB-sticks
# like ._somecrap

$theSource = "E:\"       # <<<<< insert drive here
Get-Childitem $theSource -Include @("._*", ".DS_Store", ".fseventsd", ".TemporaryItems", ".Trashes", ".Spotlight-V100") -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse