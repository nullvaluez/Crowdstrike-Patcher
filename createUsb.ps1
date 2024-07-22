# Variables
$usbDriveLetter = "E:"  # Change this to your USB drive letter
$batchFilePath = "$usbDriveLetter\fix.bat"  # Path to the batch file in the root of the USB drive

# Prepare Windows PE
Write-Host "Preparing Windows PE..."
New-Item -ItemType Directory -Force -Path C:\WinPE_amd64
Invoke-Expression "copype amd64 C:\WinPE_amd64"

# Create a bootable USB drive
Write-Host "Creating bootable USB drive..."
Invoke-Expression "MakeWinPEMedia /UFD C:\WinPE_amd64 $usbDriveLetter"

# Mount the Windows PE image
Write-Host "Mounting Windows PE image..."
Invoke-Expression "dism /Mount-Image /ImageFile:C:\WinPE_amd64\media\sources\boot.wim /index:1 /MountDir:C:\WinPE_amd64\mount"

# Create startnet.cmd to run the batch file from the USB root
Write-Host "Creating startnet.cmd..."
$startnetContent = @"
@echo off
wpeinit
for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%i:\fix.bat set usbDrive=%%i:
%usbDrive%\fix_crowdstrike.bat
"@
Set-Content -Path "C:\WinPE_amd64\mount\Windows\System32\startnet.cmd" -Value $startnetContent

# Unmount and commit the changes
Write-Host "Unmounting and committing changes..."
Invoke-Expression "dism /Unmount-Image /MountDir:C:\WinPE_amd64\mount /Commit"

Write-Host "Bootable USB with Windows PE and batch file created successfully."
