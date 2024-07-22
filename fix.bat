@echo off
setlocal enabledelayedexpansion

:: Set the drive letter for the Windows installation
set "winDrive=C:"

:: Check if running with administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run it as an administrator.
    pause
    exit /b 1
)

:: Check if BitLocker is enabled on the drive
manage-bde -status %winDrive% | find "Protection On" >nul 2>&1
if %errorlevel% equ 0 (
    echo BitLocker is enabled on %winDrive%. Please enter the recovery key to unlock the drive:
    set /p recoveryKey=Enter the BitLocker recovery key: 
    manage-bde -unlock %winDrive% -RecoveryPassword %recoveryKey% >nul 2>&1
    if %errorlevel% neq 0 (
        echo Failed to unlock %winDrive%. Please check the recovery key and try again.
        pause
        exit /b 1
    )
    echo Successfully unlocked %winDrive%.
)

:: Navigate to the CrowdStrike directory
cd /d "%winDrive%\Windows\System32\drivers\CrowdStrike"

:: Check if the directory exists
if not exist "%cd%" (
    echo CrowdStrike directory not found.
    echo Script will exit now.
    pause
    exit /b 1
)

:: Find and delete the specific file
for %%F in (C-00000291*.sys) do (
    echo Deleting file: %%F
    del "%%F"
    if !errorlevel! neq 0 (
        echo Failed to delete %%F
    ) else (
        echo Successfully deleted %%F
    )
)

echo Patch applied! You can now safely reboot the system.
pause
