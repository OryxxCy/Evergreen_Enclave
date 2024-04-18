class Order < ApplicationRecord
  belongs_to :user
  has_many :order_plants

  validates :gst_tax, :hst_tax, :pst_tax, :total, :user_id, presence: true
  validates :gst_tax, :hst_tax, :pst_tax, :total, numericality: { greater_than_or_equal_to: 0}

  def self.ransackable_associations(auth_object = nil)
    ["order_plants", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst_tax", "hst_tax", "id", "id_value", "pst_tax", "total", "updated_at", "user_id"]
  end
end
