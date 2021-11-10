require 'rails_helper'

RSpec.describe Admin::DailyMenusController, type: :controller do
  
  let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
  let(:yesterday_menu)        { create(:daily_menu, created_at: 1.day.ago,
                                                    food_items_attributes: food_items_attributes) }
  let(:new_daily_menu)        { attributes_for(:daily_menu,
                                                    food_items_attributes: food_items_attributes) }
  let!(:admin)                { create(:user) }
  let(:user)                  { create(:random_user) }
  let(:menu)                  { create(:daily_menu, food_items_attributes: food_items_attributes) }
 
  context 'unathenticated user' do

    describe 'GET /index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /show' do
      it 'redirects to login page' do
        get :show, params: { id: yesterday_menu }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /new' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST /create' do 
      it 'redirects to login page' do
        post :create, params: { daily_menu: new_daily_menu }
        expect(response).to redirect_to(new_user_session_url)
      end

      it 'doesn\'t create a new menu' do
        expect do
          patch :create, params: new_daily_menu
        end.not_to change { DailyMenu.count }
      end
    end

    describe 'GET /edit' do
      
      it 'redirects to login page' do
        get :edit, params: { id: menu }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PATCH /update' do
     
      let(:food_item) { attributes_for(:food_item, name: "Check") }
      
      it 'redirects to login page' do
        patch :update, params: { id: menu, food_items_attributes: [food_item] }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'doesn\'t update menu\'s food_items' do
        patch :update, params: { id: menu, food_items_attributes: [food_item] }
        expect(menu.food_items.where(name: "Check")).to be_empty
      end
    end
  end

  context 'when user is authorized' do
      
    before { sign_in(user) }

    describe 'GET /index' do
      it 'redirects to root path' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /show' do
      it 'redirects to root path ' do
        get :show, params: { id: yesterday_menu }
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /new' do
      it 'redirects to root path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /create' do
      it 'redirects to root path ' do
        post :create, params: { daily_menu: new_daily_menu }
        expect(response).to redirect_to(root_path)
      end
      
      it 'doesn\'t create a new menu' do
        expect do
          patch :create, params: { daily_menu: new_daily_menu }
        end.not_to change { DailyMenu.count }
      end
    end

    describe 'GET /edit' do
      it 'redirects to root path' do
        get :edit, params: { id: menu }
        expect(response).to redirect_to(root_path)
      end 
    end

    describe 'PATCH /update' do
      let(:food_item) { attributes_for(:food_item, name: "Check") }
      
      it 'redirects to root path' do
        patch :update, params: { id: menu }
        expect(response).to redirect_to(root_path)
      end

      it 'doesn\'t update menu\'s food_items' do
        patch :update, params: { id: menu, food_items_attributes: [food_item] }
        expect(menu.food_items.where(name: "Check")).to be_empty
      end
    end
  end

  context 'when user is authorized as an admin' do

    before { sign_in(admin) }

    describe 'GET /index' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end
      
      it 'assigns @facade' do
        get :index
        expect(assigns(:facade)).to be_a(Admin::DailyMenus::IndexFacade)  
      end
    end

    describe 'GET /show' do
      it 'renders show page' do
        get :show, params: { id: yesterday_menu }
        expect(response).to render_template(:show)
      end

      it 'assigns @facade' do
        get :show, params: { id: yesterday_menu }
        expect(assigns(:facade)).to be_a(Admin::DailyMenus::ShowFacade)  
      end
    end

    describe 'GET /new' do
      context "responds to" do
        it "rsponds to html by default" do
          get :new
          expect(response.content_type).to eq "text/html; charset=utf-8"
        end
    
        it "responds to json" do
          get :new, format: :json 
          expect(response.content_type).to eq "application/json; charset=utf-8"
        end
      end
     
      it 'renders new page' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns @daily_menu' do
        get :new
        expect(assigns(:daily_menu)).to be_a_new(DailyMenu)
      end

      context "when todays menu is already present" do
        
        before { menu }
        
        it 'reditects to admin_root_path' do
          get :new
          expect(response).to redirect_to(admin_root_path)
        end
  
        it "throws an alert message" do
          get :new
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'POST /create' do
      context 'with valid food_items' do

        it 'redirects to admin_daily_menu_path' do
          post :create, params: { daily_menu: new_daily_menu }
          expect(response).to redirect_to(admin_daily_menu_path(DailyMenu.last))
        end
        
        it 'creates new daily_menu in database' do
          expect do 
            post :create, params: { daily_menu: new_daily_menu }
          end.to change { DailyMenu.count }.by(1)
        end
        
        it 'creates new food_item in database' do
          expect do 
            post :create, params: { daily_menu: new_daily_menu }
          end.to change { FoodItem.count }.by(3)
        end

        it 'throws a succes notice message' do
          post :create, params: { daily_menu: new_daily_menu }
          expect(flash[:notice]).to be_present
        end
      end

      context 'with invalid food_items' do
        let(:invalid_food_item)       { attributes_for(:food_item, name: "")}
        let(:menu_with_invalid_items) { attributes_for(:daily_menu,
                                                        food_items_attributes: [invalid_food_item]) }
        
        it 'renders #new' do
          post :create, params: { daily_menu: menu_with_invalid_items }
          expect(response).to render_template(:new)
        end
        
        it 'doesn`t create new food_item in database ' do
          expect do
            post :create, params: { daily_menu: menu_with_invalid_items }
          end.not_to change(FoodItem, :count)
        end
        
        it 'doesn`t create new daily_menu in database ' do
          expect do
            post :create, params: { daily_menu: menu_with_invalid_items }
          end.not_to change(DailyMenu, :count)
        end

        it "throws an alert message" do
          post :create, params: { daily_menu: menu_with_invalid_items }
          expect(flash[:alert]).to be_present 
        end
      end

      context "when the todays manu is already present" do
        
        before { menu }
        
        it "redirects to admin_root_path" do
          post :create, params: { daily_menu: new_daily_menu }
          expect(response).to redirect_to(admin_root_path) 
        end

        it "doesn\'t create new menu in database" do
          expect do 
            post :create, params: { daily_menu: new_daily_menu }
          end.not_to change { DailyMenu.count }
        end
        
        it "throws an alert message" do
          post :create, params: { daily_menu: new_daily_menu }
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET /edit' do
      context "responds to" do
        it "rsponds to html by default" do
          get :edit, params: { id: menu}
          expect(response.content_type).to eq "text/html; charset=utf-8"
        end
    
        it "responds to json" do
          get :edit, params: { id: menu, format: :json }
          expect(response.content_type).to eq "application/json; charset=utf-8"
        end
      end

      it 'renders edit page' do
        get :edit, params: { id: menu }
        expect(response).to render_template(:edit)
      end

      it 'assigns requested daily_menu to @daily_menu' do
        get :show, params: { id: menu }
        expect(assigns(:daily_menu)).to eq(menu)
      end

      context "when the menu was created not today" do
        
        it 'reditects to admin_root_path' do
          get :edit, params: { id: yesterday_menu }
          expect(response).to redirect_to(admin_root_path)
        end
  
        it "throws an alert message" do
          get :edit, params: { id: yesterday_menu }
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'PATCH /update' do
      context 'when adding valid food_items' do
        
        let(:new_food_item) { attributes_for(:food_item) }

        it 'adds new food_item to db' do
          menu.reload
          expect do
            patch :update,
                   params: { id: menu, daily_menu: { food_items_attributes: [new_food_item] } }
          end.to change(FoodItem, :count).by(1)
        end

        it 'redirects to admin_daily_menu_path' do
          patch :update,
                 params: { id: menu, daily_menu: { food_items_attributes: [new_food_item] } }
          expect(response).to redirect_to(admin_daily_menu_path(menu))
        end

        it 'throws a succes notice message' do
          patch :update,
                 params: { id: menu, daily_menu: { food_items_attributes: [new_food_item] } }
          expect(flash[:notice]).to be_present
        end
      end

      context 'when deleting valid food_items from menu' do
        
        let(:update_attr) { menu.food_items[0].attributes.merge!(_destroy: true) }
        
        it 'removes food_item from db' do
          patch :update, params: { id: menu,
                                   daily_menu: { food_items_attributes: update_attr } }
          menu.reload
          expect(menu.food_items.size).to eq(2)
        end

        it 'redirects to admin_daily_menu_path' do
          patch :update, params: { id: menu,
                                   daily_menu: { food_items_attributes: update_attr } }
          expect(response).to redirect_to(admin_daily_menu_path(menu))
        end

        it 'throws a succes notice message' do
          patch :update, params: { id: menu,
                                   daily_menu: { food_items_attributes: update_attr } }
          expect(flash[:notice]).to be_present
        end
      end

      context 'when updating existent food_items of daily_menu' do
        
        let(:first_item_id) { menu.food_items.first.id }
        
        it 'updates existing food_item in the menu' do
          patch :update, params: { id: menu, daily_menu: { food_items_attributes: { id: first_item_id, 
                                                                                    name: "Check" }}}
          menu.reload
          expect(menu.food_items.first.name).to eq('Check')
        end

        it 'redirects to admin_daily_menu_path' do
          patch :update, params: { id: menu, daily_menu: { food_items_attributes: { id: first_item_id, 
                                                                                    name: "Check" }}}
          expect(response).to redirect_to(admin_daily_menu_path(menu))
        end

        it 'throws a succes notice message' do
          patch :update, params: { id: menu, daily_menu: { food_items_attributes: { id: first_item_id, 
                                                                                    name: "Check" }}}
          expect(flash[:notice]).to be_present
        end
      end

      context 'when adding invalid food_items' do
        
        let(:new_food_item) { attributes_for(:food_item, name: "") }

        it 'renders #edit' do
          patch :update, params: { id:           menu,
                                   daily_menu: { food_items_attributes: [new_food_item] } }
          expect(response).to render_template(:edit)
        end

        it 'doesn`t create new food_item in the menu' do
          patch :update,  params: { id:           menu,
                                    daily_menu: { food_items_attributes: [new_food_item] } }
          expect(menu.food_items.first.name).not_to eq('')
        end

        it "thorows an alert message" do
          patch :update,  params: { id:           menu,
                                    daily_menu: { food_items_attributes: [new_food_item] } }
          expect(flash[:alert]).to be_present  
        end
      end

      context "when updating existing food_item with invalid data" do
        
        let(:first_item_id) { menu.food_items.first.id }

        it 'renders :edit template' do
          patch :update, params: { id: menu, daily_menu: { food_items_attributes: { id: first_item_id, 
                                                                                    name: "" }}}
          expect(response).to render_template(:edit)
        end

        it 'doesn\'t update existing food_item in the menu' do
          old_name = menu.food_items.first.name
          patch :update, params: { id: menu, daily_menu: { food_items_attributes: { id: first_item_id, 
                                                                                    name: "" }}}
          menu.reload
          expect(menu.food_items.first.name).to eq(old_name)
        end

        it "throws an alert message" do
          patch :update, params: { id: menu, daily_menu: { food_items_attributes: { id: first_item_id, 
                                                                                    name: "" }}}
          expect(flash[:alert]).to be_present  
        end
      end
      
      context "when updating menu that was created not today" do
        
        let(:new_food_item) { attributes_for(:food_item) }

        it 'reditects to admin_root_path ' do
          patch :update,
                  params: { id: yesterday_menu, daily_menu: { food_items_attributes: [new_food_item] } }
          expect(response).to redirect_to(admin_root_path)
        end

        it "throws an alert message" do
          patch :update,
                  params: { id: yesterday_menu, daily_menu: { food_items_attributes: [new_food_item] } }
          expect(flash[:alert]).to be_present
        end

        it "doesn\'t add new food items to db" do
          yesterday_menu.reload
          expect do
            patch :update,
                   params: { id: yesterday_menu, daily_menu: { food_items_attributes: [new_food_item] } }
          end.not_to change(FoodItem, :count)
        end
      end
    end
  end
end
