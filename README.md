# README

Este documento detalla los logros y aspectos pendientes de la prueba técnica.

## Configuración del Entorno

- El backend se desplegó en un servidor VPS utilizando Docker y Docker Compose.
- El frontend fue desarrollado con Angular.
  - Sitio web : [pt.luisvergara.dev](https://pt.luisvergara.dev)
  - La web estará disponible hasta el 30 de abril.
  - Repositorio GitHub del Frontend: [GitHub Front URL](https://github.com/LuisVergara1/Prueba_TecnicaAngular)
## Backend

El backend se desarrolló utilizando Ruby on Rails:
- **Ruby versión**: 3.0.0
- **Rails versión**: 6.1.4.4
- Implementación de una base de datos utilizando PostgreSQL.
  - Para configurar las credenciales de la base de datos, tiene las siguientes opciones:
    1. Crear un archivo `.env` en la raíz del proyecto con las siguientes variables:
       - `DB_USER=postgres` 
       - `DB_PASSWORD=postgres`
       - `DB_HOST=localhost`
       - `DB_PORT=5432`
       - `DB_NAME=postgres`
       #### Modificar Valores de las variables Segun corresponda 
    2. Modificar el archivo `config/database.yml` con sus credenciales.

- Por temas de seguridad CSRF, se agregó la línea `skip_before_action :verify_authenticity_token` a los controladores, lo cual no es recomendable en producción.

### Pasos para la configuración inicial

1. Modifique sus credenciales en el archivo `.env`.
2. Ejecute los siguientes comandos:
   - `bundle install` para instalar las gemas del proyecto.
   - `rails db:migrate`
   - `rails server` para iniciar el servidor.

## Funcionalidades Implementadas

### Task Solicitada: Guardado de Información de la API Externa

- Validaciones implementadas:
  - Registro de 'features'.
  - Verificación de duplicidad del 'External Id' en la base de datos.

Comando para ejecutar:

rails earthquake_data:fetch_and_save


### EndPoint para Búsqueda de Features
* Filtración por mag_type y paginación añadidas.
* URL de ejemplo: http://localhost:3000/api/features?page=1&per_page=2&mag_type[]=md&mag_type[]=ml&mag_type[]=mb
* Ejemplo de Respuesta:
 ```json
{
  "data": [
    {
      "id": 1,
      "type": "Feature",
      "attributes": {
        "external_id": "nc74032066",
        "magnitude": "0.96",
        "place": "1 km SW of Anderson Springs, CA",
        "time": "2024-04-10 00:15:18 -0400",
        "tsunami": "false",
        "mag_type": "md",
        "title": "M 1.0 - 1 km SW of Anderson Springs, CA",
        "coordinates": {
          "longitude": "-122.7023315",
          "latitude": "38.7683334"
        }
      },
      "links": {
        "external_url": "https://earthquake.usgs.gov/earthquakes/eventpage/nc74032066"
      }
    }
  ],
  "pagination": {
    "current_page": 1,
    "total": 3359,
    "per_page": 1
  }
} 
```
#### Nota:
- **No se logró que el atributo 'tsunami' se guardara como false (booleano); se optó por guardarlo como string realizando una validación para determinar si era 0 o 1 según correspondiera.**

### EndPoint para  Crear un Commentario
- **URL**: `http://localhost:3000/api/features/:feature_id/comments/create`
- **Método**: POST
- **Parámetros**:
  - `feature_id`: Corresponde al ID asignado a un feature
  - **Ejemplo de cuerpo de la consulta**:
  ```json
  {
    "body": "Este es un comentario de ejemplo"
  }

### Endpoints Adicionales 

#### 1. Buscar una Feature por ID o External ID
- **URL**: `http://localhost:3000/api/features/:id`
- **Método**: GET
- **Parámetros**:
  - `id`: Corresponde al ID asignado en la base de datos o por su External ID.

#### 2. Listar Todos los Comentarios
- **URL**: `http://localhost:3000/api/features/comments/getall`
- **Método**: GET

#### 3. Modificar un Comentario
- **URL**: `http://localhost:3000/api/features/:comment_id/comments/update`
- **Método**: PUT
- **Parámetros**:
  - `comment_id`: Corresponde al ID asignado al crear el comentario.
- **Ejemplo de cuerpo de la consulta**:
  ```json
  {
    "body": "Este es un comentario de ejemplo actualizado"
  }

#### 4. Eliminar un Comentario
- **URL**: `http://localhost:3000/api/features/:comment_id/comments/delete`
- **Método**: DELETE
- **Parámetros**:
  - `comment_id`: Corresponde al ID asignado al crear el comentario.


