# Configuracion ZKbrowser CE7 - Falcon X4

## Dispositivo objetivo
- **Modelo:** Datalogic Falcon X4
- **SO:** Windows Embedded Compact 7 (WEC7)
- **Navegador:** ZKbrowser (Locked Web Browser)

## Archivos incluidos

| Archivo | Descripcion |
|---------|-------------|
| `configurar.bat` | Script de configuracion principal (ejecutar en el dispositivo) |
| `zkbrowser.reg` | Archivo de registro alternativo (importar en el dispositivo) |

## Homepage configurado
```
http://10.107.194.110/insp_pry/inspecciones_falcon/falcon.html
```

## Metodo 1: Script BAT (Recomendado)

### Paso 1: Copiar al dispositivo
1. Conectar el Falcon X4 al PC via USB
2. Abrir Windows Mobile Device Center (o ActiveSync)
3. Explorar el dispositivo
4. Copiar la carpeta `falcon-x4-setup` a:
   ```
   \SDMMC\Setup\   (si tiene tarjeta SD)
   o
   \Application\   (almacenamiento interno)
   ```

### Paso 2: Ejecutar en el dispositivo
1. En el Falcon X4, ir a **Explorador de Archivos**
2. Navegar hasta la carpeta copiada
3. Tocar `configurar.bat`
4. Esperar a que aparezca "CONFIGURACION COMPLETADA"

### Paso 3: Persistir cambios
1. Ir a **Panel de Control** > **Persistent Registry**
2. Tocar **Persist**
3. Tocar **OK**
4. **Reiniciar** el dispositivo

### Paso 4: Verificar
1. Despues del reinicio, ZKbrowser debe abrirse automaticamente
2. Debe cargar la pagina de inspecciones
3. Verificar que el boton "Ver/Ocultar" funciona en el campo de contrasena

---

## Metodo 2: Archivo REG (Alternativo)

### Paso 1: Copiar al dispositivo
1. Copiar `zkbrowser.reg` al dispositivo via ActiveSync/WMDC

### Paso 2: Importar registro
1. En el Falcon X4, ir a **Explorador de Archivos**
2. Tocar el archivo `zkbrowser.reg`
3. Confirmar la importacion

### Paso 3: Persistir y reiniciar
1. Ir a **Panel de Control** > **Persistent Registry** > **Persist**
2. Reiniciar el dispositivo

---

## Metodo 3: DXU (Para multiples dispositivos)

Si tiene acceso a **Datalogic DXU** (Desktop Configuration Utility):

1. Abrir DXU en el PC
2. Conectar el Falcon X4 via USB
3. Ir a **Configuration** > **Locked Web Browser**
4. Configurar:
   - **Start URL:** `http://10.107.194.110/insp_pry/inspecciones_falcon/falcon.html`
   - **Full Screen:** Enabled
   - **Address Bar:** Disabled
5. Aplicar cambios al dispositivo
6. Persistir registry y reiniciar

---

## Configuracion aplicada

| Parametro | Valor | Descripcion |
|-----------|-------|-------------|
| StartURL | `http://10.107.194.110/insp_pry/inspecciones_falcon/falcon.html` | Pagina de inicio |
| FullScreen | 1 | Modo pantalla completa |
| EnableAddressBar | 0 | Ocultar barra de direcciones |
| EnableToolBar | 0 | Ocultar barra de herramientas |
| EnableStatusBar | 1 | Mostrar barra de estado |
| TimeoutValue | 600000 (10 min) | Timeout de sesion en ms |
| ErrorPage | Misma URL | Pagina offline/fallback |

---

## Solucion de problemas

### ZKbrowser no abre automaticamente
- Verificar que el registry fue persistido (Persistent Registry > Persist)
- Reiniciar el dispositivo nuevamente

### Pagina no carga
- Verificar conexion de red (WiFi o Ethernet)
- Probar la URL desde Internet Explorer del dispositivo
- Verificar que el servidor `10.107.194.110` esta accesible

### Boton "Ver/Ocultar" no funciona
- Asegurarse de estar usando la version correcta de `falcon.html`
- El boton requiere JavaScript habilitado en ZKbrowser

### Se pierde la configuracion al reiniciar
- Asegurarse de ejecutar **Persistent Registry** > **Persist** despues de cada cambio
- Los cambios sin persistir se pierden al reiniciar

---

## Contacto
- **Departamento:** Sistemas y Mantenimiento de Planta
- **Empresa:** Goodyear Chile
