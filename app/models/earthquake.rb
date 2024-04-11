class Earthquake < ApplicationRecord
  self.inheritance_column = :_type_disabled
  has_many :comments, dependent: :destroy
    validates :external_id, uniqueness: true
    validates :external_id, :magnitude, :place, :time, :url, :tsunami, :mag_type, :title, :longitude, :latitude, presence: true
    validates :magnitude, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10.0 }
    validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
    validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  end
