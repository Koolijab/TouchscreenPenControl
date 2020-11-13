# TouchscreenPenControl
Turn on or off your touchscreen with the upper pen button while hovering (works only on digitizers)

A way to deal with bad palm rejection.


# Install
1. Install Autohotkey

2. Compile **"Touchscreen control.ahk"**  
    ***Keep "Touchscreen control.exe", "setTouchscreen.bat", "launch.vbs", in the same directory!!!***
    
3. Open the "Task sheduler" (keep everything as it is unless I tell you something else) 
    - Create a new Task
    
    - Safetyoptions:
        -activate **high priority**
    - Configure for your OS Version
    
    - Trigger:
        -**new Trigger:**
        -Start Task: **On Login**
        
    - Actions:
        -**new Action:**
        -**Start Program**
        -select your compiled **Touchscreen control.exe**
        
    The rest can stay as it is.
    
4.  Configure "setTouchscreen.bat"  
      Go to Device-Manager. Under *"Human Interface Devices"*, search for *"Touchscreen"*.  
      Open the Properties of the Touchscreen and search for *"Devicepath"* under *"Details"*-Tab  
      The Devicepath should looke something like this: `"@HID\ELAN0732&COL01\5&242C8B19&1&0000"`.  
      Copy this path and replace all such paths in *"SetTouchscreen.bat"* with your Touchscreen-path.  
      

5.  Hit "OK" and run the task / restart your PC

6. Now you should be able to turn your touchscreen on and off by pressing the **upper side-button** of your pen, **while hovering** above the screen. You schould get a notification sound feedback when the touchscreen got (de)activated.

If you don't like the sound, delete 

`rundll32.exe cmdext.dll,MessageBeepStub`  
`rundll32 user32.dll,MessageBeep`

from *"setTouchscreen.bat"*
