class DailyMenu < ApplicationRecord
  has_many :food_items, inverse_of: :daily_menu, dependent: :destroy
  has_many :orders
  accepts_nested_attributes_for :food_items, allow_destroy: true, reject_if: :all_blank
end
