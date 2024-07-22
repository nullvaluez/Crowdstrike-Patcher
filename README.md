# Crowdstrike BSOD Bootable USB Drive Fix

This guide will help you create a bootable USB drive with Windows PE that automatically runs a batch script (`fix.bat`) to address the CrowdStrike issue.

## Prerequisites

1. A USB drive (at least 1 GB).
2. Windows Assessment and Deployment Kit (ADK) and Windows PE add-on.
3. `fix.bat` script.
4. `createUsb.ps1` script.

## Steps

### 1. Download and Install Windows ADK and Windows PE Add-on

Download and install the Windows Assessment and Deployment Kit (ADK) and the Windows PE add-on from the [Microsoft website](https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install).

### 2. Prepare the Batch Script

Ensure that `fix.bat` is placed inside of the root folder for the USB drive.

### 3.) Create the Windows PE Bootable USB

Save the following PowerShell script as `createUsb.ps1` on your local machine (not on the USB drive)

### 4.) Run the PowerShell Script

1. Open PowerShell as Administrator
2. Execute the PowerShell Script by navigating to the directory where the file is located and enter the folliwing: `.\createUsb.ps1`

### 5.) Boot from the USB

1. Insert the USB drive into the target computer.
2. Boot the computer and enter the BIOS/UEFI settings to set the USB drive as the primary boot device.
3. Save the changes and reboot the computer. It should boot into the Windows PE environment and automatically run the fix.bat script.

### Summary:
1. **fix.bat**: Should be placed in the root of the USB drive.
2. **createUsb.ps1**: Should be saved and run from your local machine to create the bootable USB drive.

This setup ensures that the USB drive is prepared correctly and that the `fix.bat` script runs automatically when the system boots from the USB drive.
