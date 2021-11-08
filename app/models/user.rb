class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :orders, dependent: nil
  before_create :set_admin
  validates :name, presence: true

  include Authentication

  private

  def set_admin
    self.is_admin = User.count.zero?
  end
end
