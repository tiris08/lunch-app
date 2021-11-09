require 'rails_helper'
RSpec.describe DailyMenusController do
  
  let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
  let(:daily_menu) { create(:daily_menu, food_items_attributes: food_items_attributes) }
  let(:user) { create(:user) }

  context 'when user is unauthenticated' do
    describe 'GET /index' do
      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns @facade' do
        get :index
        expect(assigns(:facade)).to be_a(DailyMenus::IndexFacade)
      end
    end

    describe 'GET /show' do
      it 'redirects to login page' do
        get :show, params: { id: daily_menu }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when user is authorized as an admin' do
    before do
      user.update(is_admin: true)
      sign_in(user)
    end

    describe 'GET /index' do
      it 'redirects to admin root' do
        get :index
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'GET /show' do
      it 'redirects to admin root ' do
        get :show, params: { id: daily_menu }
        expect(response).to redirect_to(admin_root_path)
      end
    end
  end

  context 'when user is authorized as user' do
    before do
      user.update(is_admin: false)
      sign_in(user)
    end

    describe 'GET /index' do
      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns @facade' do
        get :index
        expect(assigns(:facade)).to be_a(DailyMenus::IndexFacade)
      end
    end

    describe 'GET /show' do
      it 'renders show' do
        get :show, params: { id: daily_menu }
        expect(response).to render_template(:show)
      end

      it 'assigns @daily_menu' do
        get :show, params: { id: daily_menu }
        expect(assigns(:daily_menu)).to eq(daily_menu)
      end
    end
  end
end
