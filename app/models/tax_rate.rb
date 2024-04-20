class TaxRate < ApplicationRecord
  has_many :users

  validates :province,:pst,:gst,:hst, presence: true
  validates :province, uniqueness: true
  validates :pst,:gst,:hst, numericality: { greater_than_or_equal_to: 0}

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "id_value", "province", "pst", "updated_at"]
  end
end
