require 'rails_helper'

RSpec.describe Api::OrdersController, type: :request do
  
  let!(:order)     { create(:order, daily_menu: daily_menu, 
                            user: user,
                            order_items_attributes: [{food_item_id: daily_menu.food_items.first.id},
                                                      {food_item_id: daily_menu.food_items.second.id}]) }
  let!(:admin)     { create(:user) }
  let(:user)       { create(:random_user) }
  let(:item1)      { attributes_for(:food_item, price: 2, course: 0) }
  let(:item2)      { attributes_for(:food_item, price: 2, course: 1) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: [item1, item2]) }
  
  context "without authorization token" do
    describe "GET/api/orders" do
      it 'returns error Not Authenticated' do
        get('/api/orders')
        json = JSON.parse(response.body)
        expect(json["errors"]).to eql(["Not Authenticated"])
      end
    end
  end

  context "with authorization token" do
    describe "GET/api/orders" do
      before do
        get '/api/orders', headers: { 'Authorization': request_token}
      end
      
      let(:json) { JSON.parse(response.body) }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it 'JSON body response contains a list of orders' do
        expect(json['orders'][0].keys).to match_array(['id', 'created_at', 'total_cost', 'food_items', 'user'])
        expect(json["orders"].size).to eql(1) 
        expect(json["orders"][0]["total_cost"]).to eql("4.0")
      end

      it 'each order contains list of food_items attributes' do
        expect(json["orders"][0]["food_items"][0].keys).to match_array(['name', 'course', 'price' ])
        expect(json["orders"][0]["food_items"][0]['name']).to eql(item1[:name])
        expect(json["orders"][0]["food_items"].size).to eql(2)
      end

      it "each order contains user attributes" do
        expect(json["orders"][0]["user"].keys).to match_array(['name', 'email'])
        expect(json["orders"][0]["user"]['name']).to eql(user.name)
      end
      
    end
  end
end
