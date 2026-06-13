# 📱 Frontend de Formulario de Inspecciones - Goodyear Chile

Este repositorio contiene la aplicación cliente (interfaz móvil y de escritorio) diseñada para que los operadores y técnicos realicen inspecciones técnicas de equipos en planta de Goodyear Chile (especialmente enfocado en el área **ASRS** y equipos de producción).

El diseño está optimizado para dispositivos móviles y terminales portátiles de captura de datos (como pistolas lectoras **Zebra TC21 / TC26 / MC3300** corriendo Android System WebViews o ZetaKey Enterprise Browser).

---

## 🚀 Características Principales

*   🔒 **Autenticación Corporativa LDAP:** Acceso seguro mediante inicio de sesión de credenciales LDAP corporativas.
*   ⏱️ **Gestión de Sesión e Inactividad (Timeout):** Para proteger la integridad de las firmas de inspección, el sistema cuenta con un cierre de sesión automático tras **40 minutos de inactividad**.
*   🔫 **Optimización para Lectores de Códigos (Scanner-Friendly):**
    *   Foco automático persistente en el buscador de equipos al iniciar.
    *   Soporte para escaneo de etiquetas QR/Barra con URLs completas (el sistema extrae automáticamente el parámetro de query `?equipo=ID`).
    *   Interfaz diseñada para evitar que el teclado táctil interfiera en el flujo de escaneo continuo.
*   📋 **Checklists Técnicas Dinámicas:** Al identificar el equipo (por escaneo o selección manual), el sistema consulta la API para descargar las preguntas técnicas específicas de la categoría del equipo (`/api/preguntas/<categoria>/`).
*   👆 **Interfaz Táctil Adaptativa:** Botones grandes y accesibles (OK / NOK / N/A) y casillas rápidas para catalogar hallazgos "Críticos" de mantenimiento.
*   📝 **Detalle de Hallazgos por Item:** Permite asociar comentarios específicos directamente a cada item evaluado como no conforme (NOK).
*   ⚙️ **Integración Transparente con SAP PM:**
    *   **Mapeo de Puestos de Trabajo:** Resuelve automáticamente el Puesto de Trabajo del técnico en SAP (`txtGEWRK`) basándose en su nombre LDAP corporativo usando un diccionario local (`user_to_puesto_map.json`).
    *   **Mapeo de Equipos:** Vincula los identificadores locales de Django con la Ubicación Técnica (TPLNR) y Código de Equipo en SAP mediante `django_to_sap_map.json`.
*   🚀 **Publicación Estática:** Exportado como HTML/JS estático listo para ser servido por servidores web livianos, Nginx, o directamente desde el almacenamiento del dispositivo.

---

## 🛠️ Tecnologías y Librerías

*   **HTML5, Vanilla CSS3 y Javascript (ES5/ES6)** para asegurar compatibilidad retroactiva absoluta con WebViews antiguos de dispositivos industriales Zebra Android.
*   **Next.js (Static Export / Build Output):** El proyecto original se genera a partir de Next.js, exportando recursos optimizados en las carpetas `_next`, `login` y `falcon`.
*   **FontAwesome 5** para iconos táctiles.
*   **XMLHttpRequest (AJAX Nativo):** Empleado en lugar de Fetch API moderna para garantizar compatibilidad con navegadores antiguos de terminales de radiofrecuencia.

---

## 🌐 Estructura del Proyecto

```markdown
├── falcon/
│   ├── falcon.html               # Formulario principal de checklist e inspección
│   ├── django_to_sap_map.json    # Diccionario de relación ID equipo -> SAP TPLNR/EQUNR
│   └── user_to_puesto_map.json   # Diccionario de relación nombre LDAP -> Puesto de Trabajo SAP
├── login/
│   └── index.html                # Interfaz de Login estática
├── 404.html                      # Página de error 404
├── index.html                    # Redirección e inicio del flujo
└── public/                       # Logotipos y recursos gráficos
```

---

## 🔌 Integraciones con el API Backend

El cliente realiza peticiones AJAX a los siguientes endpoints (configurable a través de la variable `API_URL` en el cliente o almacenamiento local):

*   `POST /api/login-ldap/` - Valida credenciales e identifica privilegios del usuario.
*   `GET /api/preguntas/<categoria>/` - Carga el listado de inspección técnica correspondiente.
*   `POST /api/guardar/` - Envía los resultados de la inspección, comentarios específicos NOK, observaciones generales y datos del equipo para su persistencia en la base de datos y su posterior creación como notificación de aviso en SAP PM.

---

## 🔧 Configuración del Servidor API

El frontend cuenta con un menú de configuración rápida para apuntar a diferentes entornos de la API (Desarrollo, QA, Producción):

1.  En la pantalla de inicio o login, utiliza la función `configureServerUrl()` (o modifica el parámetro de la variable de URL en el código).
2.  De manera alternativa, puedes definir la clave `api_url` en el `localStorage` del navegador del terminal:
    ```javascript
    localStorage.setItem("api_url", "http://10.107.194.110:8080");
    ```

---

## 🙌 Autores y Desarrollo

Proyecto mantenido y operado por el departamento de **Sistemas y Mantenimiento de Planta - Goodyear Chile**.
