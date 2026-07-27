@echo off
rem =====================================================
rem  Configuracion ZKbrowser CE7 - Falcon X4
rem  Inspecciones Goodyear Chile
rem =====================================================
rem  
rem  INSTRUCCIONES:
rem  1. Copiar esta carpeta al Falcon X4 via ActiveSync/WMDC
rem  2. Ejecutar este archivo .bat en el dispositivo
rem  3. Ir a Panel de Control > Persistent Registry > Persist
rem  4. Reiniciar el dispositivo
rem  
rem =====================================================

set HOMEPAGE=http://10.107.194.110/insp_pry/inspecciones_falcon/falcon.html

echo.
echo ========================================
echo  Configurando ZKbrowser CE7
echo  Falcon X4 - Inspecciones Goodyear
echo ========================================
echo.

rem --- Verificar que se ejecuta en el dispositivo ---
if not exist "\Windows\System32\reg.exe" (
    echo ERROR: Este script debe ejecutarse en el Falcon X4
    echo Copielo al dispositivo via ActiveSync/WMDC primero.
    echo.
    pause
    goto :eof
)

rem --- Configurar Homepage ---
echo [1/4] Configurando homepage...
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "StartURL" /t REG_SZ /d "%HOMEPAGE%" /f
if errorlevel 1 (
    echo  Intentando ruta alternativa...
    reg add "HKLM\Software\Datalogic\LockedWeb" /v "StartURL" /t REG_SZ /d "%HOMEPAGE%" /f
)

rem --- Configurar modo kiosk (pantalla completa, sin barra de direcciones) ---
echo [2/4] Configurando modo kiosk...
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "FullScreen" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "EnableAddressBar" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "EnableToolBar" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "EnableStatusBar" /t REG_DWORD /d 1 /f

rem --- Configurar timeout de sesion (10 minutos) ---
echo [3/4] Configurando timeout de sesion...
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "TimeoutValue" /t REG_DWORD /d 600000 /f

rem --- Configurar pagina de error como homepage (fallback offline) ---
echo [4/4] Configurando pagina offline...
reg add "HKLM\Software\Datalogic\MobileComputer\LockedWeb" /v "ErrorPage" /t REG_SZ /d "%HOMEPAGE%" /f

echo.
echo ========================================
echo  CONFIGURACION COMPLETADA
echo ========================================
echo.
echo IMPORTANTE: Ahora debe:
echo  1. Ir a Panel de Control
echo  2. Abrir "Persistent Registry"  
echo  3. Tocar "Persist"
echo  4. Reiniciar el dispositivo
echo.
echo Homepage configurado:
echo %HOMEPAGE%
echo.
pause
