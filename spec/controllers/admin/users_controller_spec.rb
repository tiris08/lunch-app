require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:admin) { create(:user) }
  let(:user)   { create(:random_user) }

  context 'unauthenticated user' do
    
    describe 'GET /index' do
      it 'redirects to login' do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /show' do
      it 'redirects to login' do
        get :show, params: { id: user }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  context 'authorized user' do
    
    before { sign_in(user) }

    describe 'GET /index' do
      it 'redirects to root_path' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /show' do
      it 'redirects to root_path' do
        get :show, params: { id: user }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'authorized admin' do
    
    before { sign_in(admin) }

    describe 'GET /index' do
      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns @facade" do
        get :index
        expect(assigns(:facade)).to be_a(Admin::Users::IndexFacade)
      end
    end

    describe 'GET /show' do
      it 'renders :show template' do
        get :show, params: { id: user }
        expect(response).to render_template(:show)
      end

      it 'assigns @user' do
        get :show, params: { id: user }
        expect(assigns(:user)).to eq(user)
      end

      it 'assigns @facade' do
        get :show, params: { id: user }
        expect(assigns(:facade)).to be_a(Admin::Users::ShowFacade)
      end
    end
  end
end
