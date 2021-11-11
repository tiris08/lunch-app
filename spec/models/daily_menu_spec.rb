require 'rails_helper'

RSpec.describe DailyMenu, type: :model do
  
  describe "associations" do
    it { should accept_nested_attributes_for(:food_items).allow_destroy(true) }
    it { should have_many(:food_items) }
    it { should have_many(:orders) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:food_items)}
  end
end
