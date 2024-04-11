class EarthquakesController < ApplicationController
  skip_before_action :verify_authenticity_token
    #EndPoint para Crear un Feature Manualmente
   # def create
   #   tsunami_value = nil
   #   tsunami_param = params[:tsunami].to_i
   #   if [0, 1].include?(tsunami_param)
   #     tsunami_value = (tsunami_param == 1) ? "true" : "false"
   #   else
   #     render json: { status: 'error', message: 'Error Tsunami debe ser 0 para Falso y 1 para True '}, status: :unprocessable_entity
   #     return
   #   end
      #Le asigno de Forma Autimatica "Feature"
   #   type_value = "Feature"
   #   earthquake_params = params.permit(:external_id, :magnitude, :place, :time, :url, :mag_type, :title, :longitude, :latitude)
      #Cargamos los Params de tsunami y Type luego de ser validados
   #   earthquake = Earthquake.new(earthquake_params.merge(tsunami: tsunami_value , type:type_value ))
    #  if earthquake.save
   #     render json: { status: 'success', message: 'Terremoto guardado correctamente.' }, status: :created
   #   else
   #     render json: { status: 'error', message: 'Error al guardar el terremoto.', errors: earthquake.errors.full_messages }, status: :unprocessable_entity
   #   end
   # end
  end
