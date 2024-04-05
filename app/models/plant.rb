class Plant < ApplicationRecord
  belongs_to :plant_type
  has_one_attached :image

  validates :name, :description, :price,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0}

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "plant_type"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "other_name", "plant_type_id", "price", "updated_at"]
  end
end
