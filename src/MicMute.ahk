#NoEnv		; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn		; Enable warnings to assist with detecting common errors.
SendMode Input		; Recommended for new scripts due to its superior speed and reliability.
scriptDir := A_ScriptDir
SetWorkingDir %scriptDir%		; Ensures a consistent starting directory.

; if path doesn't lead to 'src' folder, append '\src' to path
workingPath := SubStr(scriptDir, -2) != "src" ? scriptDir "\src" : scriptDir
iconPath_on := workingPath "\icon\mic_icon1.png"
iconPath_off := workingPath "\icon\mic_icon0.png"
soundPath_on := workingPath "\sounds\beepON-1.1.wav"
soundPath_off := workingPath "\sounds\beepOFF-1.1.wav"
micIdPath := workingPath "\micID.txt"

FileRead, micId, %micIdPath%

if ErrorLevel
	msgbox "Error occured while getting your microphone ID!"`n`n "Path not recognized"

SoundSet, 1, MASTER:1, MUTE, micId		; Turn off mic on start
SoundGet, MM, MASTER:1, MUTE, micId		; Component type, Mixer number

; Changes menu tray icon when gets switched on or off
Menu, Tray, Icon, % (MM == "On" ? iconPath_off : iconPath_on)

MuteMic() {
    local MM
    SoundSet, +1, MASTER:1, MUTE, micId		
    SoundGet, MM, MASTER:1, MUTE, micId		

    if (MM == "Off") {
        SoundPlay, %soundPath_on%
        Menu, Tray, Icon, %iconPath_on%		
    } else if (MM == "On") {
        SoundPlay, %soundPath_off%
        Menu, Tray, Icon, %iconPath_off%		
    }
}

RControl & AppsKey::MuteMic() 
