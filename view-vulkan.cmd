@echo off
setlocal
for %%B in ("%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%LocalAppData%\Google\Chrome\Application\chrome.exe" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe") do (
    if exist "%%~B" (
        start "" "%%~B" --no-first-run --use-angle=vulkan --user-data-dir="%LocalAppData%\EmberGrove\%%~nB" "%~dp0renderer.html"
        exit /b 0
    )
)
echo Install Chrome or Edge to use this Vulkan launcher, or open renderer.html directly.
pause
exit /b 1
