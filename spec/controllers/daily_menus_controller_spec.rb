require 'rails_helper'
RSpec.describe DailyMenusController do
  
  describe "unauthorized user" do
    
    let(:daily_menu) { daily_menu_with_food_items }

    describe "GET /index" do
      
      it "redirects to login page" do 
        get :index
        expect(response).to redirect_to(new_user_session_url) 
      end
    end

    describe "GET /show" do
      it "redirects to login page" do 
        get :show, params:{ id: daily_menu }
        expect(response).to redirect_to(new_user_session_url) 
      end
    end
  end

  describe "authorized user" do 
    
    let(:daily_menu) { daily_menu_with_food_items }
    let(:user) { create(:user) }
    
    before do
      user.update(is_admin: false)
      sign_in(user)
    end
    
    describe "GET /index" do
      
      it "renders index" do 
        get :index
        expect(response).to render_template(:index) 
      end

      it "assigns @daily_menus" do
        get :index
        expect(assigns(:daily_menus)).to eq([daily_menu]) 
      end
    end

    describe "GET /show" do
      
      it "renders show" do 
        get :show, params:{ id: daily_menu }
        expect(response).to render_template(:show) 
      end

      it "assigns requested daily_menu to @daily_menu" do
        get :show, params:{ id: daily_menu }
        expect(assigns(:daily_menu)).to eq(daily_menu) 
      end

      it "assigns @user_order" do
        get :show, params:{ id: daily_menu }
        expect(assigns(:user_order)).to eq(user.orders.find_by(daily_menu: daily_menu))
        expect(assigns(:user_order_cost)).to eq(user.orders.find_by(daily_menu: daily_menu)&.food_items&.pluck(:price)&.sum)
      end
      
    end
  end
end
