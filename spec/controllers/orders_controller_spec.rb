require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  
  let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
  let(:daily_menu)            { create(:daily_menu, food_items_attributes: food_items_attributes) }
  let!(:admin)                { create(:user, is_admin: true) }
  let(:user)                  { create(:random_user) }
  let(:user_with_no_order)    { create(:random_user) }
  let(:order)                 { build(:order, daily_menu: daily_menu, user: user) }
  let(:valid_order_attr)      { { food_item_id: daily_menu.food_items.first.id } }
  let(:delete_attr)           { order.order_items.first.attributes.merge!(_destroy: true) }
  
  before do
    3.times { order.order_items.build }
    order.order_items[0].food_item = create(:food_item, daily_menu: daily_menu, course: 0)
    order.order_items[1].food_item = create(:food_item, daily_menu: daily_menu, course: 1)
    order.order_items[2].food_item = create(:food_item, daily_menu: daily_menu, course: 2)
    order.save
  end

  context 'when user is unathenticated' do
    
    describe 'GET /index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /show' do
      it 'redirects to login page' do
        get :show, params: { id: order }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /new' do
      it 'redirects to login page' do
        get :new, params: { daily_menu_id: daily_menu }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST /create' do
      it 'redirects to login page' do
        post :create, params: { daily_menu_id: daily_menu,
                                order:         { daily_menu_id:          daily_menu,
                                                 user_id:                user_with_no_order,
                                                 order_items_attributes: [valid_order_attr] }}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /edit' do
      it 'redirects to login page' do
        get :edit, params: { daily_menu_id: daily_menu, id: order }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PATCH /update' do
      it 'redirects to login page' do
        patch :update, params: { daily_menu_id: daily_menu, 
                                 id: order, 
                                 order: { order_items_attributes: [delete_attr] }}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'DELETE /destroy' do
      it 'redirects to login page' do
        delete :destroy, params: { daily_menu_id: daily_menu, id: order }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  context 'when user is authorized as an admin' do
    
    before do
      sign_in(admin)
    end

    describe 'GET /index' do
      it 'redirects to admin_root' do
        get :index
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'GET /show' do
      it 'redirects to admin_root' do
        get :show, params: { id: order }
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'GET /new' do
      it 'redirects to admin_root' do
        get :new, params: { daily_menu_id: daily_menu }
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'POST /create' do
      it 'redirects to admin_root' do
        post :create, params: { daily_menu_id: daily_menu,  
                                order:         { daily_menu_id:          daily_menu,
                                                 user_id:                admin,
                                                 order_items_attributes: [valid_order_attr] }}
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'GET /edit' do
      it 'redirects to admin_root ' do
        get :edit, params: { daily_menu_id: daily_menu, id: order }
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'PATCH /update' do
      it 'redirects to admin_root' do
        patch :update, params: { daily_menu_id: daily_menu, id: order, 
                                 order: { order_items_attributes: [delete_attr] }}
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe 'DELETE /destroy' do
      it 'redirects to admin root' do
        delete :destroy, params: { daily_menu_id: daily_menu, id: order }
        expect(response).to redirect_to(admin_root_path)
      end
    end
  end

  context 'when user is authorized' do

    before { sign_in(user) }

    describe 'GET /index' do
      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns @facade' do
        get :index
        expect(assigns(:facade)).to be_a(Orders::IndexFacade)
      end
    end

    describe 'GET /show' do
      it 'renders :show template' do
        get :show, params: { id: order }
        expect(response).to render_template(:show)
      end
     
      it 'assigns @facade' do
        get :show, params: { id: order }
        expect(assigns(:facade)).to be_a(Orders::ShowFacade)
      end
    end

    describe 'GET /new' do
      
      before { order.destroy }

      it 'renders :new template' do
        get :new, params: { daily_menu_id: daily_menu }
        expect(response).to render_template(:new)
      end

      it 'assigns @order' do
        get :new, params: { daily_menu_id: daily_menu }
        expect(assigns(:order)).to be_a_new(Order)
      end

      it 'assigns @facade' do
        get :new, params: { daily_menu_id: daily_menu }
        expect(assigns(:facade)).to be_a(Orders::NewFacade)
      end
    end

    describe 'POST /create' do
      
      context 'without order_items' do
        it 'renders :new template' do
          post :create, params: { daily_menu_id: daily_menu,
                                  order:         { user_id:                user,
                                                   order_items_attributes: [{food_item_id: ''}] } }
          expect(response).to render_template(:new)
        end

        it 'doesn`t create new order in db' do
          expect do
            post :create, params: { daily_menu_id: daily_menu,
                                    order:         { user_id:                user,
                                                     order_items_attributes: [{food_item_id: ''}] } }
          end.not_to change(Order, :count)
        end

        it 'assigns @facade' do
          post :create, params: { daily_menu_id: daily_menu,
                                  order:         { user_id:                user,
                                                  order_items_attributes: [{food_item_id: ''}] } }
          expect(assigns(:facade)).to be_a(Orders::NewFacade)
        end

        it 'thorws an alert message' do
          post :create, params: { daily_menu_id: daily_menu,
                                  order:         { user_id:                user,
                                                  order_items_attributes: [{food_item_id: ''}] } }
          expect(flash[:alert]).to be_present
        end
      end

      context 'with valid order_items' do
        it 'redirects to order_path' do
          post :create, params: { daily_menu_id: daily_menu,
                                  order:         { daily_menu_id:          daily_menu,
                                                   user_id:                user,
                                                   order_items_attributes: [valid_order_attr] } }
          expect(response).to redirect_to(order_path(user.orders.last))
        end

        it 'creates new order_items in database' do
          expect do
            post :create, params: { daily_menu_id: daily_menu,
                                    order:         { daily_menu_id:          daily_menu,
                                                     user_id:                user,
                                                     order_items_attributes: [valid_order_attr] } }
          end.to change(OrderItem, :count).by(1)
        end

        it 'creates new order in database' do
          expect do
            post :create, params: { daily_menu_id: daily_menu,
                                    order:         { daily_menu_id:          daily_menu,
                                                     user_id:                user,
                                                     order_items_attributes: [valid_order_attr] } }
          end.to change(Order, :count).by(1)
        end

        it 'throws succes notice message' do
          post :create, params: { daily_menu_id: daily_menu,
                                  order:         { daily_menu_id:          daily_menu,
                                                   user_id:                user,
                                                   order_items_attributes: [valid_order_attr] } }
          expect(flash[:notice]).to be_present
        end
      end
    end

    describe 'GET /edit' do
      it 'renders :edit template' do
        get :edit, params: { daily_menu_id: daily_menu, id: order }
        expect(response).to render_template(:edit)
      end

      it 'assigns @facade' do
        get :edit, params: { daily_menu_id: daily_menu, id: order }
        expect(assigns(:facade)).to be_a(Orders::EditFacade)
      end
    end

    describe 'PATCH /update' do
      
      context 'with valid food_items' do
      
        let(:new_first_course) { create(:food_item, daily_menu: daily_menu, course: 0) }
        let(:new_attr) { attributes_for(:order_item, food_item_id: new_first_course.id) }
      
        it 'redirects to daily_menu path' do
          patch :update, params: { daily_menu_id: daily_menu, id: order, user_id: user,
                                  order: { order_items_attributes: [new_attr,
                                                                    delete_attr] } }
          expect(response).to redirect_to(order_path(order))
        end

        it 'updates order items in database' do
          patch :update, params: { daily_menu_id: daily_menu, id: order, user_id: user,
                                   order: { order_items_attributes: [new_attr,
                                                                     delete_attr] } }
          order.reload
          expect(order.food_items.include?(new_first_course)).to be_truthy
        end

        it 'throws succes notice message' do
          patch :update, params: { daily_menu_id: daily_menu, id: order, user_id: user,
                                   order: { order_items_attributes: [new_attr,
                                                                     delete_attr] } }
          expect(flash[:notice]).to be_present
        end
      end

      context 'without any food_items' do
        
        let(:delete_first_attr) { order.order_items.first.attributes.merge!(_destroy: true) }
        let(:delete_main_attr) { order.order_items.second.attributes.merge!(_destroy: true) }
        let(:delete_drink_attr) { order.order_items.third.attributes.merge!(_destroy: true) }
       
        it 'renders :edit template' do
          patch :update, params: { daily_menu_id: daily_menu, id: order, user_id: user,
                                   order: { order_items_attributes: [delete_first_attr, 
                                                                     delete_main_attr, 
                                                                     delete_drink_attr ] } }
          expect(response).to render_template(:edit)
        end

        it 'doesn`t update order order_items in db' do
          size = order.order_items.size
          patch :update, params: { daily_menu_id: daily_menu, id: order, user_id: user,
                                   order: { order_items_attributes: [delete_first_attr, 
                                                                     delete_main_attr, 
                                                                     delete_drink_attr ] } }
          order.reload
          expect(order.order_items.size).to eq(size)
        end

        it 'throws alert message' do
          patch :update, params: { daily_menu_id: daily_menu, id: order, user_id: user,
                                   order: { order_items_attributes: [delete_first_attr, 
                                                                     delete_main_attr, 
                                                                     delete_drink_attr ] } }
        end
      end
    end

    describe 'DELETE /destroy' do
      
      it 'redirects to daily menu path' do
        delete :destroy, params: { id: order, daily_menu_id: daily_menu }
        expect(response).to redirect_to(root_path)
      end

      it 'deletes order from database' do
        delete :destroy, params: { daily_menu_id: daily_menu, id: order }
        expect(Order.exists?(order.id)).to be_falsy
      end

      it 'deletes order items from database' do
        delete :destroy, params: { daily_menu_id: daily_menu, id: order }
        expect(OrderItem.where(order: order)).to be_empty
      end

      it 'thorows succes notice message' do
        delete :destroy, params: { daily_menu_id: daily_menu, id: order }
        expect(flash[:notice]).to be_present
      end
    end
  end
end
