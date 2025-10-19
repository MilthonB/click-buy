# Click-Buy

## Guía para correr el proyecto Flutter con Firebase

Este proyecto usa Flutter y Firebase. Para poder correrlo localmente, debes seguir los siguientes pasos.

---

> **Nota:** Este proyecto ya cuenta con soporte para Bloc/Cubit y tiene soporte para inglés y español. 


## 1️⃣ Clonar el repositorio

```bash
git clone https://github.com/MilthonB/click-buy.git
cd click-buy
```
## 2️⃣ Instalar dependencias de Flutter

```bash
flutter pub get
flutter run
```

## 3️⃣ Configurar Firebase localmente

El archivo lib/firebase_option.dart no se encuentra en el respositorio por motivos de seguridad.

1. **Crear un proyecto en Firebase:**
   - Ve a la [Firebase Console](https://console.firebase.google.com/) y crea un nuevo proyecto.

2. **Agregar tu app de Flutter:**
   - Dentro del proyecto, selecciona "Agregar app" y elige **Flutter**.
   - Sigue las instrucciones que Firebase te indique para registrar tu app.

# Configuración de Firebase (Auth + Firestore)

## Habilitar Autenticación (Email/Contraseña)
- Ve a [Firebase Console](https://console.firebase.google.com/).
- Selecciona tu proyecto.
- En el panel lateral izquierdo entra a **Compilación > Authentication**.
- Abre la pestaña **Método de acceso**.
- Activa el proveedor **Correo electrónico/contraseña**.
- Haz clic en **Guardar**.

---

## ✅ Habilitar Cloud Firestore
- En el panel lateral izquierdo entra a **Compilación > Firestore Database**.
- Haz clic en **Crear base de datos**.
- **(Edición):** Selecciona **Estándar (Standard)**.
- **Paso 1 (Ubicación):** Elige la ubicación de la base de datos → **United States** (recomendado).  
  > 🔹 No necesitas asignar un ID en este paso. 
- **Paso 2 (Modo):** Selecciona el modo de la base de datos:  
  - Seleccionamos **Modo prueba** (válido por 30 días, acceso abierto).   
- **Paso 3 (Confirmación):** Haz clic en **Habilitar**.

---

## Notas importantes
- El **Modo prueba** expira en **30 días**, deberás actualizar las reglas después.
- Si no ves **Authentication** o **Firestore Database**, asegúrate de estar en el proyecto correcto.

# Flavors 

Para usar los **3 diferentes flavor** tienes que ejecutar los siguintes comandos.

```bash
flutter run --flavor -t lib/main_dev.dart 
flutter run --flavor -t lib/main_staging.dart 
flutter run --flavor -t lib/main_prod.dart 
```

> ⚠️ **Ojo:**
>
> - En la versión **dev** está configurado el `baseUrl` de **dummyJson** correctamente.
> - En **staging** y **prod** no, esto es intencional para dar el efecto de que realmente se está ejecutando cada flavor distinto.



# ¿Por qué usaste ese patrón de estado?
Elegí este patrón de estado (AsyncValue en Riverpod) porque maneja de forma clara los distintos estados.  

- Separar la lógica de negocio de la UI: la UI simplemente observa el provider y reacciona según el estado, sin tener que preocuparse por cómo se cargan los datos.

 - Manejar operaciones asíncronas de forma segura: como estamos trayendo productos desde Firestore y una API externa, necesitamos reflejar correctamente cuando la información está cargando, cuando hay datos disponibles, o cuando ocurre un error. AsyncValue = data, loading y error, 3 estados.

# ¿Cómo estructuraste los módulos?
Organicé el proyecto en módulos según la responsabilidad de cada capa: 

- Domain: datasources, entidades, repositorios abstractos, donde está las reglas de negocio. 

- Infrastructure: implementaciones concretas de repositorios y datasources, models y mappers, interacción con Firebase o APIs externas. 

- Presentation: providers, y widgets que construyen la UI, separados por pantallas. 

- Config: clientes HTTP (Dio), themes, routes y colores. 

Esta estructura sigue principios de Clean Architecture, separando responsabilidades y facilitando pruebas unitarias, mantenimiento y escalabilidad.

# Diagrama ER
```text
+----------------+
|     User       |
|----------------|
| userId : String|
+----------------+
        |
        | 1:1
        v
+--------------------------+
|        Cart              |
|--------------------------|
| userId : String          |
| items : Array<Map>       |
+--------------------------+
        |
        | contains multiple
        v
+--------------------------+
|       Item               |
|--------------------------|
| productId : int          |
| quantity  : int          |
+--------------------------+
```

## Ejemplo de json document
```json
{
  "userId": "user123",
  "items": [
    {
      "productId": 1,
      "quantity": 2
    },
    {
      "productId": 5,
      "quantity": 1
    }
  ]
}
```

<br>
<br>


# 🚀 Guía Completa: Configuración de Firebase en un Proyecto Flutter (ClickBuy)

Esta guía explica paso a paso cómo **conectar un proyecto Flutter existente** con un **proyecto Firebase que ya está creado**, incluyendo:

- Instalación de herramientas necesarias (`Firebase CLI` y `FlutterFire CLI`)
- Descarga y colocación de archivos de configuración (`google-services.json` y `firebase_options.dart`)
- Inicialización de Firebase dentro del código Flutter

Compatible con:
- 🐧 Fedora / Debian (Linux)
- 🪟 Windows
- 🍏 macOS


## 🧩 1. Requisitos previos

### ✅ Debes tener instalado:
- **Flutter SDK**
- **Dart SDK**
- **Node.js** (incluye npm)
- **Git**

Verifica con:
```bash
flutter --version
dart --version
node -v
npm -v
```
## 🧩 2. Descargar el archivo `google-services.json` (Android)

1. Entra a [Firebase Console](https://console.firebase.google.com)
2. Selecciona tu proyecto (por ejemplo, **ClickBuy**)
3. Haz clic en el ícono del engrane ⚙️ → **Configuración del proyecto**
4. Baja hasta la sección **Tus apps**
5. En la app de Android, haz clic y presiona:  
   **“Descargar archivo `google-services.json`”**
6. Guarda el archivo en tu proyecto Flutter en la ruta: **android/app/**


📌 Este archivo vincula tu app Android con Firebase. **No lo subas a GitHub**.


## 🧩 3. (Opcional) Descargar archivo para iOS

Si usas iOS, en la misma consola de Firebase:

1. En la app de iOS, haz clic en:  
   **“Descargar `GoogleService-Info.plist`”**
2. Guárdalo en la ruta de tu proyecto Flutter: **ios/Runner/**

## 🧩 4. Instalar Firebase CLI

### 🔹 Verifica si ya lo tienes instalado
```bash
firebase --version
```

* si ves un número de versión (ej. 13.2.0), ya lo tienes.
* Si aparece “comando no encontrado”, sigue las instrucciones según tu sistema:

### 🐧 En Fedora / Debian / Linux

Primero asegúrate de tener Node.js y npm:
```bash
node -v
npm -v
```


Si no los tienes, instala Node.js:

* En Fedora:
```bash
sudo dnf install nodejs npm -y
```
* En Debian / Ubuntu:
```bash 
sudo apt install nodejs npm -y
```


Luego instala Firebase CLI globalmente:
```bash
sudo npm install -g firebase-tools
```



### 🍏 En macOS

Instala con Homebrew (recomendado):

```bash
brew install node
brew install firebase-cli
```


O con npm:
```bash
sudo npm install -g firebase-tools
```

### 🪟 En Windows

Descarga e instala Node.js desde https://nodejs.org

La instalación de Node agrega npm automáticamente.

Abre PowerShell o CMD y ejecuta:
```bash
npm install -g firebase-tools
```

### 🧩 5. Iniciar sesión en Firebase

Una vez instalado el CLI, inicia sesión con tu cuenta de Google (la misma que usas en Firebase):

Desde la terminal :
```bash
firebase login
```

Esto abrirá el navegador para autorizar la conexión.

### 🧩 6. Instalar FlutterFire CLI

El siguiente paso es instalar el CLI oficial de Flutter para Firebase.
Este comando genera el archivo firebase_options.dart, necesario para inicializar Firebase en tu proyecto Flutter.

Ejecuta desde la terminal:
```bash
dart pub global activate flutterfire_cli
```

Verifica que se haya activado correctamente:

```bash
dart pub global list
```

Deberías ver algo como:
```bash
flutterfire_cli 1.x.x
```
### 🧩 7. Agregar FlutterFire al PATH

Esto permite que el comando flutterfire funcione en cualquier carpeta.

### 🐧 Fedora / Debian (Linux)

Ejecuta desde la termial 
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

Para hacerlo permanente (recomendado):
```bash
echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```
### 🍏 macOS
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```
### 🪟 Windows

En Windows, no es necesario hacerlo manualmente, ya que el instalador de Dart agrega esta ruta automáticamente:

```bash 
%USERPROFILE%\AppData\Roaming\Pub\Cache\bin
```

Si el comando no funciona, reinicia tu terminal y prueba:
```bash
flutterfire --version
```
### 🧩 8. Generar configuración de Firebase

Ahora sí, desde la raíz de tu proyecto Flutter, ejecuta:
```bash
flutterfire configure
```
Durante el proceso:

* Selecciona tu proyecto Firebase (ejemplo: ClickBuy)

* Marca las plataformas que usarás (Android, iOS, Web)

* Espera unos segundos...

* Al finalizar, verás un mensaje como:

* Generated file lib/firebase_options.dart

Ese archivo contiene toda la configuración de Firebase (API keys, projectId, etc).




