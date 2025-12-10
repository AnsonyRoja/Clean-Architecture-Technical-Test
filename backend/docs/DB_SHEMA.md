# 📑 ESQUEMA DE BASE DE DATOS: Artículos

Este esquema define la estructura de los documentos en la colección `articles` en Firebase Firestore y la referencia de las miniaturas en Cloud Storage.

## 1. Colección: `articles` 📰

| Campo | Tipo de Dato | Requerido | Descripción | Notas de Validación |
| :--- | :--- | :--- | :--- | :--- |
| **`id`** | String | Sí | ID del documento (generado por Firestore). | |
| **`autorId`** | String | Sí | ID del Autor, que hace referencia al esquema o tabla autores. | |
| **`description`**| String | No |  Informacion del articulo | Ninguno |
| **`title`** | String | Sí | Título del artículo. | String, no puede estar vacío. |
| **`publishedAt`** | Timestamp | Sí | Fecha y hora de publicación. | Generado por el servidor. |
| **`urlToImage`**| String | Sí | URL de descarga de la imagen miniatura. | **Debe ser una URL válida de Cloud Storage.** |

## 1. Colección: `Autores` 📰

| Campo | Tipo de Dato | Requerido | Descripción | Notas de Validación |
| :--- | :--- | :--- | :--- | :--- |
| **`id`** | String | Sí | ID del documento (generado por Firestore). | |
| **`usersId`** | String | Sí | ID del usuario | |
| **`autor`** | String | Sí | Nombre del autor | |
| **`telefono`**| String | No |  Informacion de contacto | es opcional |
| **`email`** | String | Sí |  Forma de contacto | String, no puede estar vacío. |
| **`pais`** | String | No | País de origen o residencia del autor. | Opcional, ayuda a filtrar por ubicación. |
| **`especialidad`**| String | No | Área de especialización del autor. | Opcional, útil para filtros y recomendaciones. |

## 1. Colección: `Users` 📰

| Campo | Tipo de Dato | Requerido | Descripción | Notas de Validación |
| :--- | :--- | :--- | :--- | :--- |
| **`id`** | String | Sí | ID del documento (generado por Firestore). | |
| **`telefono`**| String | No |  Informacion de contacto | es opcional |
| **`email`** | String | Sí |  Correo de validacion | String, no puede estar vacío. |
| **`password`** | String | Sí |  Password | Cadena de caracteres con codigo cifrado, no puede estar vacío. |



## 2. Configuración de Firebase Cloud Storage 🖼️

Las miniaturas de los artículos se guardan en la siguiente ruta:

* **Ruta del Depósito:** `media/articles/{articleId}/thumbnail.jpg`
* **Relación:** El campo `urlToImage` en Firestore contiene la URL pública de este archivo.