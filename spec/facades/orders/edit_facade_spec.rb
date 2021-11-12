require 'rails_helper'

RSpec.describe Orders::EditFacade, type: :facade do
  
  let(:facade) { Orders::EditFacade.new(order, params) }
  let(:params) { {daily_menu_id: daily_menu.id} }
  let(:order)      { create(:order, daily_menu: daily_menu, 
                      user: user,
                      order_items_attributes: [{food_item_id: daily_menu.food_items.first.id},
                                              {food_item_id: daily_menu.food_items.second.id},
                                              {food_item_id: daily_menu.food_items.last.id}]) }
  let!(:admin)     { create(:user) }
  let(:user)       { create(:random_user) }
  let(:item1)      { attributes_for(:food_item, course: 0) }
  let(:item2)      { attributes_for(:food_item, course: 1) }
  let(:item3)      { attributes_for(:food_item, course: 2) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: [item1, item2, item3]) }

  describe "#daily_menu" do
    it "returns decorated daily_menu" do
      expect(facade.daily_menu).to be_a(DailyMenuDecorator)
      expect(facade.daily_menu).to eq(daily_menu)
    end
  end
  
  describe "#food_items_collection" do
    it "returns valid for a given course food_items" do
      expect(facade.food_items_collection('first_course')).to eq([daily_menu.food_items.first])
      expect(facade.food_items_collection('main_course')).to eq([daily_menu.food_items.second])
    end
  end

  describe "#first_course_item" do
    
    context "when first_course_item is present" do
      it "returns order item with first course" do
        expect(facade.first_course_item).to eq(order.order_items.first)
        expect(facade.first_course_item.food_item.course).to eq(order.order_items.first.food_item.course)
      end
    end

    context "when first_course_item is not present" do
      it "returns a new instance of associated order item" do
        order.order_items.first.destroy
        expect(facade.first_course_item).to be_a_new(OrderItem)
        expect(facade.first_course_item.order).to eql(order)
      end
    end 
  end

  describe "#main_course_item" do
    
    context "when main_course_item is present" do
      it "returns order item" do
        expect(facade.main_course_item).to eq(order.order_items.second)
      end
    end

    context "when main_course_item is not present" do
      it "returns a new instance of associated order item" do
        order.order_items.second.destroy
        expect(facade.main_course_item).to be_a_new(OrderItem)
        expect(facade.main_course_item.order).to eql(order)
      end
    end 
  end

  describe "#drink_item" do
    
    context "when drink is present" do
      it "returns order item" do
        expect(facade.drink_item).to eq(order.order_items.last)
      end
    end

    context "when drink_item is not present" do
      it "returns a new instance of associated order item" do
        order.order_items.last.destroy
        expect(facade.drink_item).to be_a_new(OrderItem)
        expect(facade.drink_item.order).to eql(order)
      end
    end 
  end
end