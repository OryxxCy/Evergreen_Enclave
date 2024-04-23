class OrderStatus < ApplicationRecord
  has_many :orders

  validates :status, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "status", "updated_at"]
  end
end
