#Modulos Necesarios
require 'json'
require 'net/http'
class SaveEarthquakeDataService

  def fetch_save_data
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    count = self.class.perform(response) # Asegurarse de llamar a perform correctamente
    count
  end

  def self.perform(data)
    json_data = JSON.parse(data)
    features = json_data['features']

    saved_count = 0
    features.each do |feature|
      properties = feature['properties']
      coordinates = feature['geometry']['coordinates']

      next unless validate_data(properties, coordinates)

      if Earthquake.exists?(external_id: feature['id'])
        puts "El terremoto con external_id #{feature['id']} ya existe, no se guardará nuevamente."
        next
      end

    tsunami_value = properties['tsunami'].to_i == 1 ? "true" : "false"

   # puts "Valor de tsunami (to_i): #{tsunami_value}"
      earthquake = Earthquake.new(
        type: feature['type'],
        external_id: feature['id'],
        magnitude: properties['mag'],
        place: properties['place'],
        time: Time.at(properties['time'] / 1000), # Convertir a segundos
        url: properties['url'],
        tsunami: tsunami_value,
        mag_type: properties['magType'],
        title: properties['title'],
        longitude: coordinates[0],
        latitude: coordinates[1]
      )

    if earthquake.nil?
      puts "Datos no válidos. El terremoto no se pudo crear."
    elsif earthquake.save
      saved_count+=1
      puts "Se han guardado #{saved_count} terremotos correctamente."

    else
      puts "Error al guardar el terremoto: #{earthquake.errors.full_messages.join(', ')}"
    end
  end
    saved_count
  end
  def self.validate_data(properties, coordinates)
    return false if properties['mag'].nil? || properties['mag'] < -1.0 || properties['mag'] > 10.0
    return false if properties['place'].nil? || properties['magType'].nil? || properties['title'].nil?
    return false if coordinates.nil? || coordinates[0].nil? || coordinates[1].nil?
    return false if coordinates[0] < -180.0 || coordinates[0] > 180.0 || coordinates[1] < -90.0 || coordinates[1] > 90.0
    return false if properties['tsunami'].nil? || ![0, 1].include?(properties['tsunami'])
    true
  end
end
