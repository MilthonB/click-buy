# Click-Buy

## Guía para correr el proyecto Flutter con Firebase

Este proyecto usa Flutter y Firebase. Para poder correrlo localmente, debes seguir los siguientes pasos.

---

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

3. **Configurar la base de datos para desarrollo:**
   - Para propósitos de prueba, puedes ajustar las reglas de Firestore para permitir lectura y escritura temporalmente:
     ```bash
        allow read, write: if true;
     ```
   - ⚠️ **Importante:** Esto solo se recomienda para desarrollo y pruebas.

4. **Resultado final:**
   - Una vez completado, tu proyecto Flutter estará vinculado a Firebase y listo para ejecutar, usando tus propias credenciales locales.


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

 
