#NoEnv		; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn		; Enable warnings to assist with detecting common errors.
SendMode Input		; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.

GetActiveExplorerPath() {
	explorerHwnd := WinActive("ahk_class CabinetWClass")

	if (explorerHwnd) {
		for window in ComObjCreate("Shell.Application").Windows {
			if (window.hwnd==explorerHwnd) {
				return window.Document.Folder.Self.Path
			}
		}
	}
}

AEP := GetActiveExplorerPath()
workingPath := SubStr(AEP, -2) != "src" ? AEP "\src" : AEP

iconPath_on := workingPath "\icon\mic_icon1.png"
iconPath_off := workingPath "\icon\mic_icon0.png"
soundPath_on := workingPath "\sounds\beepON-1.1.wav"
soundPath_off := workingPath "\sounds\beepOFF-1.1.wav"
micIdPath := workingPath "\micID.txt"

FileRead, micId, %micIdPath%

if ErrorLevel
	msgbox "Error occured while getting your microphone ID!"`n`n "Path not recognized"

; this line will always turn off mic when program starts
; SoundSet, 1, MASTER:1, MUTE, micId		; Component type, Mixer number
SoundGet, MM, MASTER:1, MUTE, micId		

; This will change tray icon depending if mic is turned on or off
if (MM == "Off") {
    Menu, Tray, Icon, %iconPath_on%		; Changes menu tray icon 
} 
else if (MM == "On") {
    Menu, Tray, Icon, %iconPath_off%      
}

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
