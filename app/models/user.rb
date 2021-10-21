class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :orders
  before_create :set_admin
  validates :name, presence: true

  private

  def set_admin
    self.is_admin = User.count.zero?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    user ||= User.create(name:     data['name'],
                         email:    data['email'],
                         password: Devise.friendly_token[0, 20])
    user
  end
end
