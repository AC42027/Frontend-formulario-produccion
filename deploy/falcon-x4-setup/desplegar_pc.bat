@echo off
rem =====================================================
rem  Desplegar configuracion a Falcon X4
rem  Ejecutar desde el PC con ActiveSync/WMDC
rem =====================================================

setlocal EnableDelayedExpansion

echo.
echo ========================================
echo  Despliegue Falcon X4 - Inspecciones
echo ========================================
echo.

rem --- Verificar que hay un dispositivo conectado ---
echo Verificando conexion con Falcon X4...
set DEVICE=
for /f "tokens=*" %%a in ('rapiinit /list 2^>nul') do (
    set DEVICE=%%a
)

if "%DEVICE%"=="" (
    echo.
    echo No se detecto ningún Falcon X4 conectado.
    echo.
    echo Verifique que:
    echo  1. El Falcon X4 esta encendido
    echo  2. Esta conectado via USB
    echo  3. ActiveSync/WMDC esta abierto en el PC
    echo  4. La conexion esta autorizada en el dispositivo
    echo.
    pause
    goto :eof
)

echo Dispositivo detectado: %DEVICE%
echo.

rem --- Crear carpeta en el dispositivo ---
echo Creando carpeta de configuracion...
mkdir "\Application\falcon-x4-setup" 2>nul

rem --- Copiar archivos ---
echo Copiando archivos de configuracion...
copy /Y "%~dp0configurar.bat" "\Application\falcon-x4-setup\" >nul
copy /Y "%~dp0zkbrowser.reg" "\Application\falcon-x4-setup\" >nul

if errorlevel 1 (
    echo.
    echo ERROR: No se pudieron copiar los archivos
    echo Verifique la conexion USB y la autorizacion en el dispositivo
    echo.
    pause
    goto :eof
)

echo.
echo Archivos copiados correctamente.
echo.

rem --- Ejecutar configuracion en el dispositivo ---
echo Ejecutando configuracion en el Falcon X4...
echo (Esto puede tardar unos segundos)
echo.

rem --- Intentar ejecutar via rapiexec ---
if exist "\Windows\rapiexec.exe" (
    rapiexec "\Application\falcon-x4-setup\configurar.bat"
) else (
    echo No se pudo ejecutar automaticamente.
    echo Por favor, ejecute manualmente en el Falcon X4:
    echo   \Application\falcon-x4-setup\configurar.bat
)

echo.
echo ========================================
echo  DESPLIEGUE COMPLETADO
echo ========================================
echo.
echo Siguientes pasos manuales en el Falcon X4:
echo  1. Ir a Panel de Control
echo  2. Persistent Registry > Persist
echo  3. Reiniciar el dispositivo
echo.
pause
