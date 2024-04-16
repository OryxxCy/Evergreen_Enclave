class Customer < ApplicationRecord
  belongs_to :tax_rate
  has_many :orders

  validates :first_name,:last_name, :tax_rate_id, :email, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["orders", "tax_rate"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "first_name", "id", "id_value", "last_name", "tax_rate_id", "updated_at"]
  end

end
