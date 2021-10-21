class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: proc { |attributes|
                                                                                attributes['food_item_id'].blank?
                                                                              }
  has_many :food_items, through: :order_items
  belongs_to :user
  belongs_to :daily_menu
  validates :order_items, presence: true
  validate :uniq_food_items_course, :todays_menu_food_items

  def uniq_food_items_course
    valid_order_items = order_items.select { |e| e unless e._destroy }
    return if valid_order_items.map { |e| e.food_item.course }.uniq == valid_order_items.map do |e|
                                                                         e.food_item.course
                                                                       end

    errors.add(:order_items, 'You can`t order more than one item from each course')
  end

  def todays_menu_food_items
    return if order_items.all? { |order_item| order_item.food_item.created_at.today? }

    errors.add(:order_items, 'You can`t order food from different menu')
  end
end
