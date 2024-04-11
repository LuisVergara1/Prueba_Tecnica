# README

* Se Detalla los Logros y No Logros de la Prueba Tecnica 

            Solicitados en la Prueba Tecnica

* PD : EL Backend lo levante en un servidor vps utilizando docker y docker compose.
    * El front fue Hecho con Angular 
        * URL: pt.luisvergara.dev 
            * La web estara disponible hasta el 30 de abril 
            * GitHub_Front_URL :    

1) Se Desarrollo el Backend Utilizando Ruby and Rails
    
    * Se implemento una Base de Datos utilizando  Postgres 
        * Para agregar sus Credenciales de Base de Datos tiene 2 opciones:
            1) Crear un archivo .env en la raiz del proyecto con las siguientes variables: 
                * DB_USER = postgres
                * DB_PASSWORD = postgres
                * DB_HOST = localhost
                * DB_PORT = 5432
                * DB_NAME = postgres
            2) Modificar el archivo config/database.yml con sus credenciales 

    * Por Temas de CSRF a los controllers se le agrego la linea 
        * skip_before_action :verify_authenticity_token
            * Lo cual no es Recomendable en Produccion 

    *------------------------------------------------*
     * Al Copiar el Repositorio :
        * Modificar sus Credenciales del Archivo .env
        * Ejecutar los siguientes comandos : 
            * bundle install Para instalar las gemas del Proyecto
            * rails db:migrate 
            * rails server Para iniciar el Programa 
    *------------------------------------------------*

2) Task Solicitada Guardando la Informacion de la Api Externa
    * Se Logro Validar : 
        * El registro de Features
        * Si el External Id ya se encuentra en la Base de Datos

            Comando a Ejecutar
    *--------------------------------------*
    * rails earthquake_data:fetch_and_save
    *--------------------------------------*



3) EndPoint Solicitado para Busqueda de Features
    * Se Logro Filtrar por Mag_Type y Agregar Paginacion a la busqueda
        * Al realizar la busqueda  se entrega informacion como fue solicitado
    * URL de Ejemplo : http://localhost:3000/api/features?page=1&per_page=1&mag_type[]=md&mag_type[]=ml&mag_type[]=mb
        * Parametros:
            * page=1 Corresponde al Numero de la pagina 
            * per_page=2 Corresponde Al numero de Feature por pagina
            * mag_type[]= Corresponde al Filtro segun el Mag_type elegido
        * Nota : Para Agregar mas Filtros de tipo mag_type agregar a la url : &mag_type[]=mb
            * METODO::GET      
    * Ejemplo de Respuesta :
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

Nota: No pude lograr que Tsunami se guardara como false(booleano) a lo cual opte por guardarlo como String 
Haciendo una validacion para comprobar si era 0 o 1 Segun corresponda 

3) EndPoint para Crear Comentarios Segun un Feature 
    *  URL: http://localhost:3000/api/features/:feature_id/comments/create
        * Parametros:
            * feature_id : (Int)Corresponde al Id Asignado en la Base de Datos
        * METODO::POST
        * Body de la Consulta:
            {
                "body": "Este es un comentario de ejemplo"
            }

            **------------------------------------------**
                        EndPoint Adicionales 
            **------------------------------------------**

1) EndPoint para Buscar una Feature Segun su ID o External Id     
    * URL del EndPoint  http://localhost:3000/api/features/:id
        * Parametros :
            * :id puede ser tanto el Id Interno(INT) como el external Id(String)
        * METODO::GET

2) EndPoint para Listar todos los Comentarios
    * Permite Listar todos los Comentarios
        * URL: http://localhost:3000/api/features/comments/getall
            * METODO::GET

3) EndPoint para Modificar un Comentario
    * URL: http://localhost:3000/api/features/:comment_id/comments/update
        * Parametros
            * comment_id : int Asignado al crear el comentario
        * METODO ::PUT
            * Body de la Consulta:
                {
                    "body": "Este es un comentario de ejemplo Actualizado"
                }

4) EndPoint para Eliminar un Comentario
    * URL: http://localhost:3000/api/features/:comment_id/comments/delete
        * Parametros
            * comment_id : int Asignado al crear el comentario
        * METODO ::DELETE

5) EndPoint para Listar los Comentarios Segun Feature
    * URL: http://localhost:3000/api/features/comments/:id_feature
        * Parametros
            * id_feature : int Asignado al crear el feature
        * METODO ::GET






