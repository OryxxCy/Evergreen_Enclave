class OrderPlant < ApplicationRecord
  belongs_to :order
  belongs_to :plant
end
