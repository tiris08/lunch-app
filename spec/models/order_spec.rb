require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:daily_menu) }
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:food_items).through(:order_items) }
    it { should accept_nested_attributes_for(:order_items) }
  end

  describe "validations" do
    
    it { should validate_presence_of(:order_items) }
    
    context "when ordering more than one food_item with the same course" do

      it "is not valid" do
        user = create(:user)
        user.update(is_admin: false)
        food_items = attributes_for_list(:food_item, 2, course: 1)
        daily_menu = create(:daily_menu, food_items_attributes: food_items)
        order_items_attributes = { "0": { food_item_id: daily_menu.food_items.first.id },
                                   "1": { food_item_id: daily_menu.food_items.second.id} }
        order = build(:order, daily_menu: daily_menu, user: user, order_items_attributes: order_items_attributes)
        expect(order.valid?).to be_falsy
      end
    end

    context "when ordering food_items that are not created today" do
      it "is not valid" do
        user = create(:user)
        user.update(is_admin: false)
        food_item = attributes_for(:food_item, created_at: 1.day.ago)
        daily_menu = create(:daily_menu, created_at: 1.day.ago, food_items_attributes: [food_item])
        order_items_attributes = { food_item_id: daily_menu.food_items.first.id }
        order = build(:order, daily_menu: daily_menu, user: user, order_items_attributes: [order_items_attributes])
        expect(order.valid?).to be_falsy
      end
    end   
  end 
end
