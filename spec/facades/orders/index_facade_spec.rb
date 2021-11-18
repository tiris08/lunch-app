require 'rails_helper'

RSpec.describe Orders::IndexFacade, type: :facade do
  let!(:admin)     { create(:user) }
  let!(:order)     do
    create(:order, daily_menu:             daily_menu,
                   user:                   user,
                   order_items_attributes: [food_item_id: daily_menu.food_items.first.id])
  end
  let(:facade)     { Orders::IndexFacade.new(user, params) }
  let(:params)     { { page: '1' } }
  let(:user)       { create(:random_user) }
  let(:item)       { attributes_for(:food_item, price: 2, course: 0) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: [item]) }

  describe '#paginated_user_orders' do
    it 'returns paginated user orders' do
      expect(facade.paginated_user_orders).to be_a(PaginatingDecorator)
      expect(facade.paginated_user_orders.first).to eq(order)
    end
  end
end
