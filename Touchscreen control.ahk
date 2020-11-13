#include AHKHID.ahk

; This script was adapted from a script graciously provided by 
; Justice Frangipane from Tablet Pro (www.tabletpro.net), to
; specifically remap the side button on the Surface Pen to the
; right mouse button while the pen is hovering on the screen.
; Now used to turn on and off the touchscreen.

; In order to run this script, you'll need AutoHotKey and AHKHID.ahk
; AutoHotKey can be downloaded here:
; https://autohotkey.com/foundation/

; AHKHID.ahk can be downloaded here:
; https://github.com/jleb/AHKHID/

; INSTRUCTIONS:
; Place AHKHID.ahk in the same directory as this script, then run the
; following script AS ADMINISTRATOR:

; AutoHotKey.exe hover-right-click.ahk

; You can also make a batch file that runs this command and add it to your
; startup folder so that it runs automatically when your PC starts.

; If you find this script useful, consider Tablet Pro as well. It's a cool
; SW and the guys there (Justice) freely shared their knowledge.

; Disclaimer: this script is provided "as is". The author(s) shall not be
; liable for any damage caused by the use of this script or its derivatives,
; etc. I've only done minor testing of this script and it works for me.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Singleinstance force
; Surface Pro 3 AutoHotkey
; https://github.com/jonathanyip/Surface-Pro-3-AutoHotkey
;
; Update History:
; Base version, Sep 14, 2016.
; First Release: Apr 10, 2017
; Last Updated: Apr. 15, 2017 by Leo Reyes
; Modified: Nov. 12, 2020 by Kilian Bertram
; Remapped upper sidebutton to turn on or off touchscreen

; Set up our pen constants
global PEN_NOT_HOVERING := 0x0 ; Pen is moved away from screen.
global PEN_HOVERING := 0x1 ; Pen is hovering above screen.
global PEN_TOUCHING := 0x3 ; Pen is touching screen.
global PEN_2ND_BTN_HOVERING := 0x5 ; 2nd button is pressed.


; This is where we remap the side button to the right-click events.
PenCallback(input, lastInput) {
    if (input = PEN_2ND_BTN_HOVERING And lastInput = PEN_HOVERING) {
		Run, launch.vbs
    }
}


; Set up other constants
; USAGE_PAGE and USAGE might change on different devices. 13/2 works for 
; the Surface Pen
WM_INPUT := 0xFF
USAGE_PAGE := 13
USAGE := 2

; Set up AHKHID constants
AHKHID_UseConstants()

; Register the pen
AHKHID_AddRegister(1)
AHKHID_AddRegister(USAGE_PAGE, USAGE, A_ScriptHwnd, RIDEV_INPUTSINK)
AHKHID_Register()

; Intercept WM_INPUT
OnMessage(WM_INPUT, "InputMsg")

; Callback for WM_INPUT
; Isolates the bits responsible for the pen states from the raw data.

InputMsg(wParam, lParam) {
    Local type, inputInfo, inputData, raw, proc
    static lastInput := PEN_NOT_HOVERING
    
    Critical

    type := AHKHID_GetInputInfo(lParam, II_DEVTYPE)
    if (type = RIM_TYPEHID) {
        inputData := AHKHID_GetInputData(lParam, uData)
        
	raw := NumGet(uData, 0, "UInt")
        proc := (raw >> 8) & 0x1F

	if (proc <> lastInput) {
        	PenCallback(proc, lastInput)
        	lastInput := proc
	}
    }
}

