class CreateEarthquakes < ActiveRecord::Migration[7.1]
  def change
    create_table :earthquakes do |t|
      t.string :external_id, null: false
      t.string :type
      t.decimal :magnitude, precision: 5, scale: 2, null: false
      t.string :place, null: false
      t.string :time, null: false
      t.string :tsunami, null:false
      t.string :mag_type, null: false
      t.string :title, null: false
      t.decimal :longitude, precision: 10, scale: 7, null: false
      t.decimal :latitude, precision: 10, scale: 7, null: false
      t.string :url
      t.timestamps
    end
    add_index :earthquakes, :external_id, unique: true
  end
end
