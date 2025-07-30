# # APPLICATION	REMOVAL COMMAND
#
# 3D Builder
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
# Sway
Get-AppxPackage *sway* | remove-AppxPackage
# Alarms & Clock
Get-AppxPackage *alarms* | Remove-AppxPackage
# Calculator
Get-AppxPackage *calculator* | Remove-AppxPackage
# Calendar and Mail
Get-AppxPackage *communicationsapps* | Remove-AppxPackage
# Get Office
Get-AppxPackage *officehub* | Remove-AppxPackage
# AV1 Codec
Get-AppxPackage *AV1VideoExtension* | Remove-AppxPackage
# VP9 Video Extensions
Get-AppxPackage *VP9VideoExtensions* | Remove-AppxPackage
# News app
Get-AppxPackage *BingNews* | Remove-AppxPackage
# Weather
Get-AppxPackage *BingWeather* | Remove-AppxPackage
# Sports
Get-AppxPackage *bingsports* | Remove-AppxPackage
# News, Sports, and Weather apps
Get-AppxPackage *bing* | Remove-AppxPackage
# WebP image support
Get-AppxPackage *WebpImageExtension* | Remove-AppxPackage
# HEIF image support
Get-AppxPackage *HEIFImageExtension* | Remove-AppxPackage
# Music app
Get-AppxPackage *ZuneMusic* | Remove-AppxPackage
# Movies and TV
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage
# Get Help app
Get-AppxPackage * GetHelp* | Remove-AppxPackage
# Voice Recorder
Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage
# Photos
Get-AppxPackage *photos* | Remove-AppxPackage
# MS Office
Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage
# Windows Camera
Get-AppxPackage *camera* | Remove-AppxPackage
# Skype
Get-AppxPackage *skype* | Remove-AppxPackage
# Maps
Get-AppxPackage *maps* | Remove-AppxPackage
# Microsoft Solitaire Collection
Get-AppxPackage *solitaire* | Remove-AppxPackage
# Get Started
Get-AppxPackage *Getstarted* | Remove-AppxPackage
# OneNote
Get-AppxPackage *onenote* | Remove-AppxPackage
# People
Get-AppxPackage *people* | Remove-AppxPackage
# Your Phone Companion
Get-AppxPackage *yourphone* | Remove-AppxPackage
# Microsoft Store
Get-AppxPackage *windowsstore* | Remove-AppxPackage
# Voice Recorder
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
# Screen & Sketch/Snipping tool
Get-AppxPackage *ScreenSketch* | Remove-AppxPackage
# Spotify
Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage
# Microsoft Edge
Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage
# Teams/Chat
Get-AppxPackage *Teams* | Remove-AppxPackage
# Microsoft To-Do
Get-AppxPackage *Todos* | Remove-AppxPackage
# Sticky Notes
Get-AppxPackage *MicrosoftStickyNotes* | Remove-AppxPackage
# Feedback Hub
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
# PowerAutomate
Get-AppxPackage *PowerAutomateDesktop* | Remove-AppxPackage
# Xbox Game Callable
Get-AppxPackage *XboxGameCallable* | Remove-AppxPackage
# Xbox Gaming Overlay
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
# Xbox TCUI
Get-AppxPackage *Xbox.TCUI* | Remove-AppxPackage
# Windows Terminal
Get-AppxPackage *WindowsTerminal* | Remove-AppxPackage
# Xbox Speech To Text Overlay
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
# Xbox and all related apps
Get-AppxPackage *Xbox* | Remove-AppxPackage
# MS Paint
Get-AppxPackage *Paint* | Remove-AppxPackage
# Notepad
Get-AppxPackage *WindowsNotepad* | Remove-AppxPackage
# ECApp
Get-AppxPackage *ECApp* | Remove-AppxPackage
# Mixed Reality Portal
Get-AppxPackage *MixedReality* | Remove-AppxPackage
# Screen Sketch
Get-AppxPackage *ScreenSketch* | Remove-AppxPackage
# Clip Champ
Get-AppxPackage *Clipchamp* | Remove-AppxPackage
# Capture Picker
Get-AppxPackage *CapturePicker* | Remove-AppxPackage

winget uninstall "Microsoft.Skype"
