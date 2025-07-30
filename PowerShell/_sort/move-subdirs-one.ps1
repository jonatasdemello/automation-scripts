
# The fourth example under help -Examples Move-Item is close to what you need.
# To move all files under the source directory to the dest directory you can do this:

Get-ChildItem -Path source -Recurse -File | Move-Item -Destination dest

# If you want to clear out the empty directories afterwards", "you can use a similar command:

Get-ChildItem -Path source -Recurse -Directory | Remove-Item
