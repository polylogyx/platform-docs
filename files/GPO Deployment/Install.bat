@echo off

(wmic computersystem get domain | findstr /v Domain | findstr /r /v "^$") > fqdn.txt

set /p FQDN=<fqdn.txt

set FQDN=%FQDN: =%

echo %FQDN%

SET PLGXDIR=C:\plgx-temp
SET PLGXINSTALLDIR=C:\Program Files\plgx_osquery

SET PLGXBIN=plgx_cpt.exe

SET PLGXCERT=certificate.crt

SET GLBPLGXBIN=\\%FQDN%\sysvol\%FQDN%\plgx\%PLGXBIN%


SET GLBPLGXCERT=\\%FQDN%\sysvol\%FQDN%\plgx\%PLGXCERT%



sc query "plgx_cpt" | find "STATE" | find "RUNNING"
If "%ERRORLEVEL%" NEQ "0" (

goto :startplgx

) ELSE (

goto :checkversion

)

:startplgx
sc start plgx_cpt

If "%ERRORLEVEL%" EQU "1060" (

goto :installplgx

) ELSE (

goto :checkversion

)


:installplgx

IF Not EXIST %PLGXDIR% (

mkdir %PLGXDIR%

)

xcopy %GLBPLGXBIN% %PLGXDIR% /y

xcopy %GLBPLGXCERT% %PLGXDIR% /y

chdir %PLGXDIR%

%PLGXBIN% -p -i <PolyLogyx ESP Server IP address> -k %PLGXCERT% 

goto :checkversion


:: Check if sysmon64.exe matches the hash of the central version 

:checkversion

chdir %PLGXINSTALLDIR%

%PLGXBIN% -c > runningver.txt


EXIT /B 0

