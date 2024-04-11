namespace :earthquake_data do
  desc "Obtener Datos de Api Externa y Guardarla en la BD"
  task fetch_and_save: :environment do
    service = SaveEarthquakeDataService.new
    saved_count = service.fetch_save_data
    puts "#{saved_count} Features Guardados ."
  end
end
