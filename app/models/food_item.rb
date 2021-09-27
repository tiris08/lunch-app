class FoodItem < ApplicationRecord
  enum course: [:first_course, :main_course, :drink]
  belongs_to :daily_menu
  has_many :order_items
  has_many :orders, through: :order_items  
  validates :name, presence: true
  validates :price, presence: true
  validates :course, presence: true
end
