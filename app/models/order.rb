class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :order_items, limit: 3
  has_many :food_items, through: :order_items
  belongs_to :user
  belongs_to :daily_menu
end
