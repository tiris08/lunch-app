require 'rails_helper'

RSpec.describe Orders::NewFacade, type: :facade do
  
  let(:facade)     { Orders::NewFacade.new(order, params) }
  let(:params)     { {daily_menu_id: daily_menu.id} }
  let(:order)      { build(:order) }
  let(:item1)      { attributes_for(:food_item, price: 2, course: 0) }
  let(:item2)      { attributes_for(:food_item, price: 2, course: 1) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: [item1, item2]) }
  
  describe "#initialize" do
    it "bulids 3 order_items" do
      expect(facade.order.order_items.size).to eql(3)   
    end
  end

  describe "#daily_menu" do
    it "returns decorated daily_menu of order" do
      expect(facade.daily_menu).to be_a(DailyMenuDecorator)
      expect(facade.daily_menu).to eql(daily_menu)   
    end
  end

  describe "#food_items_collection" do
    it "returns valid for a given course food_items" do
      expect(facade.food_items_collection('first_course')).to eq([daily_menu.food_items.first])
      expect(facade.food_items_collection('main_course')).to eq([daily_menu.food_items.last])
    end
  end
end