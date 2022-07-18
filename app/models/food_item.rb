class FoodItem < ApplicationRecord
  enum course: { first_course: 0, main_course: 1, drink: 2 }
  belongs_to :daily_menu
  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  validates :name, presence: true
  validates :price, presence: true
  validates :course, presence: true
end
