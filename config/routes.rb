Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check


         #EndPoint Solicitados en la Prueba Tecnica.
  #Buscar Features Segun Mag_Type y Paginacion
  get 'api/features' , to: 'features#search'

  #EndPoint para Crear un Comments
  post 'api/features/:feature_id/comments/create', to: 'comment#create_comment'


#para Obtener el Body y Ejemplo de las URL  Leer README

  #-------------------------------------------------

  #     EndPoint Adicionales

  #Buscar Features Segun id o external id
  get 'api/features/:id' , to: 'features#search_by_id'


  #EndPoint para Modificar el Comentario PD: No permite Modificar el Feature
  put 'api/features/:comment_id/comments/update', to: 'comment#update_comment'

  #EndPoint para Eliminar un Comentario
  delete 'api/features/:comment_id/comments/delete', to: 'comment#destroy_comment'

  #EndPoint para Obtener todos los Comentarios
  get 'api/features/comments/getall', to: 'comment#get_all'

  #EndPoint para Obtener todos los Comentarios Segun el Feature
  get 'api/features/comments/:id_feature', to: 'comment#get_by_id'
  #-------------------------------

  #EndPoint Create Feature
  #post 'api/features/create' , to: 'earthquakes#create'
  #Nota EndPoint Documentado por falta de Validacion al Campo Fecha
end
