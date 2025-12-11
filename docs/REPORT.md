# Reporte de Prueba Técnica – Symmetry

## Primeras impresiones
Al inicio, la prueba me resultó bastante desafiante, fue como "ver chino" ya que no entendía nada al principio. Sin embargo, poco a poco fui comprendiendo y logré cumplir los objetivos planteados.  

El aprendizaje fue muy valioso; me permitió revivir conocimientos que tenía olvidados y comprender mejor la arquitectura de la aplicación. Esta prueba me ayudó a entender las bases principales: la estructura de la aplicación, la configuración, la lógica de negocio, la presentación o vistas, todo bien modularizado con un patrón de diseño global como **Bloc**. Además, volví a trabajar con clases abstractas, algo que no hacía desde hace casi un año.  

Observé también un **respaldo local** con una base de datos creada con SQLite. Todo esto estaba comprimido en una sola aplicación, lo cual fue increíble y me permitió reforzar conceptos que quizás había olvidado.

---

## Desafíos y aprendizajes
Uno de los mayores desafíos fue entender cómo funciona el código y dónde reside la lógica del negocio, ya que muchas tareas están delegadas:

- Existe una carpeta **local** que guarda todos los datos lógicos en la base de datos local.
- Existe una carpeta **remota**, y al principio me costó entender cómo se comunicaba con todo.
- Uso del objeto **GetIt** para guardar instancias de clases como repositorios, Bloc, Cubit, entre otros.

A pesar de las adversidades, pude comprender cómo funciona la **arquitectura limpia** en Flutter.  

Para mí, fue un antes y un después en el aprendizaje del patrón **Bloc**, ya que nunca había visto una arquitectura tan bien organizada. Esto me motivó a seguir aprendiendo y mejorando en el desarrollo de aplicaciones.

---

## Funcionalidades implementadas y mejoras
- **Interfaz gráfica:** se mejoró la experiencia visual en la homepage, artículos y detalles.
- **Nuevas funcionalidades:**  
  - Registro de artículos de noticias actuales.  
  - Conexión con base de datos local y Firebase Emulator.  
  - Validación de campos en frontend y backend.  
  - Corrección de bugs, incluyendo un error de configuración en la carga de imágenes.
- **Ideas de mejora:**  
  - Botón de **like** en las noticias para identificar relevancia.  
  - Filtro por fechas en los artículos guardados localmente.  
  - Modo oscuro.  
  - Acceso rápido al editor de noticias.  
  - Grabador de voz instantáneo, con atajo o botón en la pantalla principal (HOME).  
  - Funcionalidad de **borrador rápido** para periodistas que guardan información constantemente.

---

## Observaciones y conclusiones
- La arquitectura limpia y modularizada permite entender y escalar la aplicación fácilmente.  
- La prueba reforzó conocimientos en Bloc, SQLite, Firebase y patrones de diseño en Flutter.  
- Se evidencia la importancia de un respaldo remoto adicional para la información almacenada localmente.  

Estoy muy agradecido por esta oportunidad. Pude dar lo mejor de mí y aplicar tanto **velocidad**, **diseño moderno** como **mentalidad de producto**. Espero poder aportar estos valores a Symmetry en el futuro.

---

**Autor:** Ansony Rojas 
