require 'rails_helper'

RSpec.describe FoodItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:course) }
    it { should define_enum_for(:course) }
  end

  describe 'associations' do
    it { should belong_to(:daily_menu).dependent(false) }
    it { should have_many(:order_items) }
    it { should have_many(:orders).through(:order_items) }
  end
end
