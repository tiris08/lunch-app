class OrderSerializer < ActiveModel::Serializer
  has_many :food_items
  belongs_to :user
  attributes :id, :total_cost, :created_at

  def total_cost
    object.food_items&.pluck(:price)&.sum
  end
end
