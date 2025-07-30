# 1. Press Windows Key + R and type SYSDM.CPL in Run. Click OK or press Enter key.

# Execute the following command to disable Search Indexing.

sc stop “wsearch” && sc config “wsearch” start=disabled

# Run the commands:

DISM /Online /Cleanup-Image /RestoreHealth

DISM /online /cleanup-image /startcomponentcleanup /resetbase

DISM /online /cleanup-image /startcomponentcleanup

Chkdsk c: /f /r /x

sfc /scannow

# ---------------------------------------------------------------------------------------------------
