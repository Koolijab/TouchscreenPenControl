COLOR 0A
D:
cd D:\Windows Kits\10\Tools\x64
for /f "tokens=3" %%a in ('devcon status "@HID\ELAN0732&COL01\5&242C8B19&1&0000"^|find "Device is"') do set "status=%%a"
@echo status is %status%
IF "%status%" == "" (
  devcon disable "@HID\ELAN0732&COL01\5&242C8B19&1&0000"
) ELSE (
  devcon enable "@HID\ELAN0732&COL01\5&242C8B19&1&0000"
)
rundll32.exe cmdext.dll,MessageBeepStub
rundll32 user32.dll,MessageBeep