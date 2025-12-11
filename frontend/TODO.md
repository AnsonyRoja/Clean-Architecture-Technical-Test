# Plan de Implementación: Widget para Crear Artículos

## Información Recopilada:
- El archivo `create_article.dart` está vacío
- Existe una entidad `ArticleEntity` con campos: id, author, title, description, urlToImage, publishedAt, content
- El FloatingActionButton en `daily_news.dart` tiene un TODO que necesita ser reemplazado
- Las rutas están definidas en `routes.dart`

## Plan de Implementación:

### 1. Crear Widget CreateArticle (create_article.dart)
- Formulario con campos para título, descripción y selección de imagen
- Botón "Publish Article" 
- Validación de campos requeridos
- Manejo de estado local para los campos del formulario
- Navegación de regreso después de crear el artículo

### 2. Actualizar Rutas (routes.dart)
- Agregar ruta para la página CreateArticle

### 3. Conectar con Home Page (daily_news.dart)
- Reemplazar TODO del FloatingActionButton con navegación a CreateArticle

### 4. Características Técnicas:
- Usar TextFormField para título y descripción
- Implementar ImagePicker para seleccionar imagen
- Validación de campos obligatorios
- Botón de publicar que valida y procesa el artículo

## Archivos a Editar:
1. `/lib/features/daily_news/presentation/pages/article/crate_article/create_article.dart` - Crear/llenar con el widget completo
2. `/lib/config/routes/routes.dart` - Agregar nueva ruta
3. `/lib/features/daily_news/presentation/pages/home/daily_news.dart` - Conectar FAB

## Próximos Pasos:
- Implementar el widget CreateArticle
- Actualizar rutas
- Probar la funcionalidad
