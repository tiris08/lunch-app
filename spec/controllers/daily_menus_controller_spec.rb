require 'rails_helper'
RSpec.describe DailyMenusController do
  describe 'unauthorized user' do
    let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
    let(:daily_menu) { create(:daily_menu, food_items_attributes: food_items_attributes) }

    describe 'GET /index' do
      it 'redirects to login page with alert flash' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET /show' do
      it 'redirects to login page with alert flash' do
        get :show, params: { id: daily_menu }
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'authorized admin' do
    let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
    let(:daily_menu) { create(:daily_menu, food_items_attributes: food_items_attributes) }
    let(:user) { create(:user) }

    before do
      user.update(is_admin: true)
      sign_in(user)
    end

    describe 'GET /index' do
      it 'redirects to admin root with alert flash' do
        get :index
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:alert]).to be_present
      end
    end

    describe 'GET /show' do
      it 'redirects to admin root with alert flash' do
        get :show, params: { id: daily_menu }
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'authorized user' do
    let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
    let(:daily_menu) { create(:daily_menu, food_items_attributes: food_items_attributes) }
    let(:user) { create(:user) }

    before do
      user.update(is_admin: false)
      sign_in(user)
    end

    describe 'GET /index' do
      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET /show' do
      it 'renders show' do
        get :show, params: { id: daily_menu }
        expect(response).to render_template(:show)
      end

      it 'assigns requested daily_menu to @daily_menu' do
        get :show, params: { id: daily_menu }
        expect(assigns(:daily_menu)).to eq(daily_menu)
      end

      it 'assigns @user_order @user_order_cost' do
        get :show, params: { id: daily_menu }
        expect(assigns(:user_order)).to eq(user.orders.find_by(daily_menu: daily_menu))
        expect(assigns(:user_order_cost)).to eq(user.orders
                                                    .find_by(daily_menu: daily_menu)
                                                    &.food_items
                                                    &.pluck(:price)
                                                    &.sum)
      end
    end
  end
end
