require 'rails_helper'

RSpec.describe Admin::DailyMenus::ShowFacade, type: :facade do
  
  before(:context)  { Rails.application.load_seed }
  after(:context)   { DatabaseCleaner.clean_with :truncation}
  let(:facade)      { Admin::DailyMenus::ShowFacade.new(daily_menu) }
  let(:daily_menu)  { DailyMenu.last }
  
  
  describe "#decorated_daily_menu" do
    
    it "returns decorated daily_menu" do
      expect(facade.decorated_daily_menu).to be_a(DailyMenuDecorator)
      expect(facade.decorated_daily_menu).to eq(daily_menu)
    end
  end

  describe "#orders_size" do
    it "returns number of menu orders" do
      size = daily_menu.orders.size
      expect(facade.orders_size).to be_eql(size)
    end
  end
  
  describe "#total_sold" do
    it "returns decorated sum of all orders cost" do
      total = daily_menu.orders.includes(:food_items).pluck(:price).sum
      expect(facade.total_sold).to be_eql("$#{total}0")
    end
  end

  describe "#menu_orders" do
    it "returns decorated orders of daily_menu" do
      expect(facade.menu_orders).to be_a(PaginatingDecorator)
      expect(facade.menu_orders).to eq(daily_menu.orders)
    end
  end

  describe "#most_popular_first_course" do
    it "returns name of most poplar first course item" do
      name = daily_menu.food_items.where(course: 0).group_by{ |e| e.order_items.size }
                                                   .max
                                                   .last[0]
                                                   .name
      expect(facade.most_popular_first_course).to eql(name)
    end   
  end

  describe "#most_popular_main_course" do
    it "returns name of most poplar main course item" do
      name = daily_menu.food_items.where(course: 1).group_by{ |e| e.order_items.size }
                                                   .max
                                                   .last[0]
                                                   .name
      expect(facade.most_popular_main_course).to eql(name)
    end   
  end

  describe "#most_popular_drink" do
    it "returns name of most poplar drink" do
      name = daily_menu.food_items.where(course: 2).group_by{ |e| e.order_items.size }
                                                   .max
                                                   .last[0]
                                                   .name
      expect(facade.most_popular_drink).to eql(name)
    end   
  end
end