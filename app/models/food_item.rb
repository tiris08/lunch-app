class FoodItem < ApplicationRecord
  enum course: { first_course: 0, main_course: 1, drink: 2 }
  belongs_to :daily_menu
  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  validates :name,   presence: true
  validates :price,  presence: true
  validates :course, presence: true
  # make sure to render errors properly
  validates :image,  content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: 'must be a valid image format' },
                     size:         { less_than: 1.megabyte,
                                     message: 'should be less than 1MB' }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
