    ; Use the SoundCardAnalysis script to figure out where your mic is
    ; https://www.autohotkey.com/docs/commands/SoundSet.htm#Ex

    ; Write up by KraZe_EyE Inspired by code seen in DirMenu.ahk (highly recommended)
    ; http://www.autohotkey.com/board/topic/91109-favorite-folders-popup-menu-with-gui/

    ; http://www.autohotkey.com/board/topic/121982-how-to-give-your-scripts-unique-icons-in-the-windows-tray/
    ; http://www.iconarchive.com/show/multipurpose-alphabet-icons-by-hydrattz.html
    ; Please note that this icon pack is not available for commercial use!

;-----------------------------------------------------------------------------------------------------

#NoEnv		; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn		; Enable warnings to assist with detecting common errors.
SendMode Input		; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.

micId = 10
workingPath := "D:\User\Documents\MicMute\src\"
iconPath_on := workingPath "icon\mic_icon1.png"
iconPath_off := workingPath "icon\mic_icon0.png"
soundPath_on := workingPath "sounds\beepON-1.1.wav"
soundPath_off := workingPath "sounds\beepOFF-1.1.wav"

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
