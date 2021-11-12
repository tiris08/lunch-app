require 'rails_helper'

RSpec.describe DailyMenus::IndexFacade, type: :facade do
  
  let(:facade) { DailyMenus::IndexFacade.new(params) }
  let(:params) { {page: "1"} }
  
  describe "#paginated_daily_menus" do
    before do 
      food_items_attributes = attributes_for_list(:food_item, 3) 
      create_list(:daily_menu, 11, food_items_attributes: food_items_attributes) 
    end
    it "returns 10 decorated daily_menus per page " do
      expect(facade.paginated_daily_menus).to be_a(PaginatingDecorator)
      expect(facade.paginated_daily_menus.size).to eql(10)   
    end
  end
end