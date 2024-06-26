class PlantType < ApplicationRecord
  has_many :plants

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["plants"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
