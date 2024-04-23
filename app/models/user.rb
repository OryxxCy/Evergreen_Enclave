class User < ApplicationRecord
  belongs_to :tax_rate, foreign_key: :province_id
  has_many :orders

  validates :firstname, :lastname, :address, :postal_code, :province_id, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d\z/, message: "It must be a valid Canadian postal code." }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_associations(auth_object = nil)
    ["orders", "tax_rate"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "firstname", "id", "id_value", "lastname", "postal_code", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
