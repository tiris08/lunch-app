class DailyMenu < ApplicationRecord
  has_many :food_items, dependent: nil
  has_many :orders, dependent: nil
  accepts_nested_attributes_for :food_items, allow_destroy: true, reject_if: :all_blank
  validates :food_items, presence: true
end
