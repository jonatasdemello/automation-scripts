# # APPLICATION	REMOVAL COMMAND

# 3D Builder
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
# Sway
Get-AppxPackage *sway* | remove-AppxPackage
# Calendar and Mail
Get-AppxPackage *communicationsapps* | Remove-AppxPackage
# Get Office
Get-AppxPackage *officehub* | Remove-AppxPackage
# News app
Get-AppxPackage *BingNews* | Remove-AppxPackage
# Weather
Get-AppxPackage *BingWeather* | Remove-AppxPackage
# Sports
Get-AppxPackage *bingsports* | Remove-AppxPackage
# Music app
Get-AppxPackage *ZuneMusic* | Remove-AppxPackage
# Movies and TV
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage
# Skype
Get-AppxPackage *skype* | Remove-AppxPackage
# Maps
Get-AppxPackage *maps* | Remove-AppxPackage
# Microsoft Solitaire Collection
Get-AppxPackage *solitaire* | Remove-AppxPackage
# Get Started
Get-AppxPackage *Getstarted* | Remove-AppxPackage
# Your Phone Companion
Get-AppxPackage *yourphone* | Remove-AppxPackage
# Spotify
Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage
# Teams/Chat
Get-AppxPackage *Teams* | Remove-AppxPackage
# Sticky Notes
Get-AppxPackage *MicrosoftStickyNotes* | Remove-AppxPackage
# Feedback Hub
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
# PowerAutomate
Get-AppxPackage *PowerAutomateDesktop* | Remove-AppxPackage
# Mixed Reality Portal
Get-AppxPackage *MixedReality* | Remove-AppxPackage
# Screen Sketch
Get-AppxPackage *ScreenSketch* | Remove-AppxPackage
# Clip Champ
Get-AppxPackage *Clipchamp* | Remove-AppxPackage


winget uninstall "Microsoft.Skype"
