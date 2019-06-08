#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetCapsLockState, AlwaysOff
;
; Spotify love
;

SpotifyLove(flag)
{
; Save the current window and mouse position so we can revert back after controlling Spotify.

WinGetActiveTitle, CurOpen
MouseGetPos, MouseX, MouseY

IfWinExist ahk_exe Spotify.exe ; check if spotify is open
	winactivate ahk_exe Spotify.exe
else
	return
WinWait ahk_exe Spotify.exe
;WinActivate ahk_exe Spotify.exe
;WinWaitActive ahk_exe Spotify.exe
Click, 65, 65 ; Spotify has a 60x60 pixel window with the menu in the top left corner. I have not find another way to activate the the main window except for this click. Any other solutions to are much appreciated.

WinGetPos, X, Y, W, H, A ; get the dimensions of the spotify window

; start searching for image in a rectangle. The first point of the rectangle X1,Y1 is 100 pixels above the bottom left corner. The other point of the rectangle X2,Y2 is 600 pixels right of the left edge and along the bottom of the window.

X1 := 0
X2 := 600
Y1 := H - 100
Y2 := H

; imagesearch is really crappy. *70 gives the function some leeway to find the right image in the window. We are searching for the heart. 

ImageSearch, OutputVarX, OutputVarY, X1, Y1, X2, Y2, *70 C:\Users\stagj030689\Pictures\Screenshots\heart.jpg

; click on heart if we like the song, click on the dislike button and "i dont like this song" otherwise.

if (flag == 1)
{
	Click, %OutputVarX%, %OutputVarY%
} else {
HateX := OutputVarX+50
DontLikeSongX := HateX+10
DontLikeSongY := OutputVarY-10
Click, %HateX%, %OutputVarY%
Sleep, 200
Click, %DontLikeSongX%, %DontLikeSongY%
}

; return to previous window with the same mouse position. 
WinActivate, %CurOpen%
MouseMove, %MouseX%, %MouseY% 
}

CapsLock & s::
SpotifyLove(1)
Return

CapsLock & d::
SpotifyLove(0)
Return
