class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  before_create :set_admin
  validates :name, presence: true

  private
  
  def set_admin
    self.is_admin = User.count == 0
  end
end
