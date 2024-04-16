class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_plants

  validates :gst_tax, :hst_tax, :pst_tax, :total, presence: true
  validates :gst_tax, :hst_tax, :pst_tax, :total, numericality: { greater_than_or_equal_to: 0}

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_plants"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "gst_tax", "hst_tax", "id", "id_value", "pst_tax", "total", "total_price", "updated_at"]
  end
end
