class Plant < ApplicationRecord
  belongs_to :plant_type

  validates :name, :description, :price,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0}
end
