require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  describe "unauthorized user" do

    describe "GET /index" do
      it "redirects to login page with alert flash" do 
        get :index
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "GET /show" do
      
      let(:user) { create(:user) }

      it "redirects to login page with alert flash" do 
        get :show, params:{ id: user }
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present  
      end
    end
  end

  describe "authorized user" do 
    
    let(:user) { create(:user) }
    
    before do
      user.update(is_admin: false)
      sign_in(user)
    end

    describe "GET /index" do
      it "redirects to root_path with alert flash" do 
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /show" do
      it "redirects to admin root_path with alert flash" do 
        get :show, params:{ id: user }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present 
      end
    end
    
 
    
    describe "authorized admin" do
    
      let(:food_items_attributes) { attributes_for_list(:food_item, 3)}
      let(:daily_menu) { create(:daily_menu, food_items_attributes: food_items_attributes) }
      let(:admin) { create(:user)}
      let(:user) { create(:random_user) }
  
      
      before do
        admin.update(is_admin: true)
        sign_in(admin)
      end
  
      describe "GET /index" do
      
        it "renders index" do 
          get :index
          expect(response).to render_template(:index) 
        end
  
        it "assigns @users" do
          get :index
          expect(assigns(:users)).to eq([user, admin]) 
        end
      end
  
      describe "GET /show" do
        it "renders show" do 
          get :show, params:{ id: user }
          expect(response).to render_template(:show) 
        end
  
        it "assigns requested user to @user" do
          get :show, params:{ id: user }
          expect(assigns(:user)).to eq(user) 
        end
      end
    end
  end
end
