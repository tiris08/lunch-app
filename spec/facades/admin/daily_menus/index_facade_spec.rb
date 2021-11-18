require 'rails_helper'

RSpec.describe Admin::DailyMenus::IndexFacade, type: :facade do
  let(:facade)      { Admin::DailyMenus::IndexFacade.new(params) }
  let(:params)      { { page: '1' } }
  let(:item1)       { attributes_for(:food_item, price: 2, course: 0) }
  let(:item2)       { attributes_for(:food_item, price: 2, course: 1) }
  let!(:daily_menu) { create(:daily_menu, food_items_attributes: [item1, item2]) }

  describe '#paginated_daily_menus' do
    it 'returns paginated daily_menus' do
      expect(facade.paginated_daily_menus).to be_a(PaginatingDecorator)
      expect(facade.paginated_daily_menus).to eq([daily_menu])
    end
  end

  describe '#edit_or_create_menu_link' do
    context 'when daily menu for today is present' do
      it 'returns a button for editing the menu' do
        expect(facade.edit_or_create_menu_link).to include('Edit a menu for today')
      end
    end

    context 'when daily menu for today is not yet created' do
      it 'returns a button for creating a new menu ' do
        daily_menu.food_items.each(&:destroy)
        daily_menu.destroy
        expect(facade.edit_or_create_menu_link).to include('Create a menu for today')
      end
    end
  end
end
