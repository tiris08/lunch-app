require 'rails_helper'

RSpec.describe Order, type: :model do
  
  describe "associations" do
    it { should belong_to(:daily_menu) }
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:food_items).through(:order_items) }
    it { should accept_nested_attributes_for(:order_items).limit(3)}
  end
end
