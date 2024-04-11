require 'clockwork'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.minute, 'fetch_and_save') do
    # Llama a tu tarea de rake aquí
    system('bundle exec rake earthquake_data:fetch_and_save')
  end
end
