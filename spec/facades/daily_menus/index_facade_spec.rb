require 'rails_helper'

RSpec.describe DailyMenus::IndexFacade, type: :facade do
  let!(:admin) { create(:user) }
  let(:facade) { DailyMenus::IndexFacade.new(params, current_user) }
  let(:current_user) { create(:random_user) }
  let(:params) { {page: "1"} }
  let!(:daily_menus) { create_list(:daily_menu, 11, food_items_attributes: food_items_attributes) }
  let(:food_items_attributes) { attributes_for_list(:food_item, 3) }
  
  describe "#paginated_daily_menus" do
    it "returns 10 decorated daily_menus per page " do
      expect(facade.paginated_daily_menus).to be_a(PaginatingDecorator)
      expect(facade.paginated_daily_menus.size).to eql(10)   
    end
  end

  describe "#active_unactive_menu_link" do
    context "when user is authenticated and daily menu is not created today" do
      it "returns active menu link to history" do
        daily_menus.last.update(created_at: 1.day.ago)
        expect(facade.active_unactive_menu_link(daily_menus.last)).to include("History" )
      end
    end

    context "when user is authenticated and daily menu  created today" do
      it "returns active menu link to history" do
        expect(facade.active_unactive_menu_link(daily_menus.last)).to include("Make an order" )
      end
    end

    context "when user is not authenticated" do
      it "returns unactive menu link" do
        facade = DailyMenus::IndexFacade.new(params, nil)
        expect(facade.active_unactive_menu_link(daily_menus.last)).to include("History", "You have to sign in first")
      end
    end
  end
end