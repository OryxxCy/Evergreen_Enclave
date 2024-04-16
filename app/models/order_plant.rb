class OrderPlant < ApplicationRecord
  belongs_to :order
  belongs_to :plant

  validates :quantity, :ordered_price, presence: true
  validates :quantity, :ordered_price, numericality: { greater_than_or_equal_to: 0}

  def self.ransackable_associations(auth_object = nil)
    ["order", "plant"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "order_id", "ordered_price", "plant_id", "quantity", "updated_at"]
  end
end
