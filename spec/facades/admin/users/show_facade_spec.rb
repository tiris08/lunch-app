require 'rails_helper'

RSpec.describe Admin::Users::ShowFacade, type: :facade do
  
  let!(:admin) { create(:user) }
  let(:facade) { Admin::Users::ShowFacade.new(user, params) }
  let(:params) { { id: user.id } }
  let(:user)   { create(:random_user) }
  let(:item1)      { attributes_for(:food_item, price: 2, course: 0) }
  let(:item2)      { attributes_for(:food_item, price: 2, course: 1) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: [item1, item2]) }
  let!(:order)      { create(:order, daily_menu: daily_menu, 
                              user: user,
                              order_items_attributes: [{food_item_id: daily_menu.food_items.first.id},
                                                      {food_item_id: daily_menu.food_items.second.id}]) }
  
  describe "#decorated_user" do
    it "returns decorated_user" do
      expect(facade.decorated_user).to be_a(UserDecorator)
      expect(facade.decorated_user).to eq(user)   
    end
  end

  describe "#user_total_spending" do
    it "returns decorated sum of all user orders cost" do
      expect(facade.user_total_spending).to eql('$4.00')  
    end
  end

  describe "#user_total_orders" do
    it "returns sum of all user\'s orders" do
      expect(facade.user_total_orders).to eql(1)  
    end
  end

  describe "#paginated_user_orders" do
    it "returns all paginated user orders" do
      expect(facade.paginated_user_orders).to be_a(PaginatingDecorator)
      expect(facade.paginated_user_orders).to eq([order])
    end
  end

end