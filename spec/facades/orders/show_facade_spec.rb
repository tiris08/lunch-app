require 'rails_helper'

RSpec.describe Orders::ShowFacade, type: :facade do
  let(:facade)     { Orders::ShowFacade.new(order) }
  let(:order)      do
    create(:order, daily_menu:             daily_menu,
                   user:                   user,
                   order_items_attributes: [{ food_item_id: daily_menu.food_items.first.id },
                                            { food_item_id: daily_menu.food_items.second.id }])
  end
  let!(:admin)     { create(:user) }
  let(:user)       { create(:random_user) }
  let(:item1)      { attributes_for(:food_item, price: 2, course: 0) }
  let(:item2)      { attributes_for(:food_item, price: 2, course: 1) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: [item1, item2]) }

  describe '#user_order_cost' do
    it 'returns total cost for order' do
      expect(facade.user_order_cost).to eql(4)
    end
  end

  describe '#user_order_items' do
    it 'return food items records' do
      expect(facade.user_order_items.first).to be_a(FoodItem)
      expect(facade.user_order_items.size).to eql(2)
    end
  end
end
