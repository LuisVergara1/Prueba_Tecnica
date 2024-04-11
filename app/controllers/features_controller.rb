class FeaturesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #EndPoint para Filtrar por Mag_Type y paginación
  def search
    features = Earthquake.all

    if params[:mag_type].present?
      mag_types = Array(params[:mag_type]) # Convertir a un arreglo si no lo es
      clean_mag_types = mag_types.map { |mag_type| mag_type.gsub(/[^a-zA-Z]/, '') }
      features = features.where(mag_type: clean_mag_types)
    end

    # Paginar los resultados
    per_page = params[:per_page].to_i
    per_page = 1000 if per_page > 1000
    page = params[:page].to_i || 1
    total = features.count
    features = features.limit(per_page).offset((page - 1) * per_page)
    # Formatear los resultados según el formato requerido
    data = features.map do |feature|
      {
        id: feature.id,
        type: feature.type,
        attributes: {
          external_id: feature.external_id,
          magnitude: feature.magnitude,
          place: feature.place,
          time: feature.time.to_s, # Convertir el tiempo a un formato de cadena
          tsunami: feature.tsunami,
          mag_type: feature.mag_type,
          title: feature.title,
          coordinates: {
            longitude: feature.longitude,
            latitude: feature.latitude
          }
        },
        links: {
          external_url: feature.url
        }
      }
    end
    render json: {
      data: data,
      pagination: {
        current_page: page,
        total: total,
        per_page: per_page
      }
    }
  end

#Buscamos un Feature Segun su id o External_id
  def search_by_id
    if params[:id].present?
      if numeric?(params[:id])
        feature = Earthquake.find_by(id: params[:id])
      else
        feature = Earthquake.find_by(external_id: params[:id])
      end
      #Si la Busqueda del feature es Valida Formatemos la Respuesta Json
      if feature
        data = {
          id: feature.id,
          type: feature.type,
          attributes: {
            external_id: feature.external_id,
            magnitude: feature.magnitude,
            place: feature.place,
            time: feature.time.to_s,
            tsunami: feature.tsunami,
            mag_type: feature.mag_type,
            title: feature.title,
            coordinates: {
              longitude: feature.longitude,
              latitude: feature.latitude
            }
          },
          links: {
            external_url: feature.url
          }
        }
        #renderizamos la Respuesta
        render json: { data: data }
      else
        render json: { error: "Feature not found" }, status: :not_found
      end
    else
      render json: { error: "Query parameter is missing" }, status: :bad_request
    end
  end
  private
  #Funcion de Ayuda para Validar si un Numero
  def numeric?(string)
    string.to_s.match?(/\A\d+\z/)
  end

end
