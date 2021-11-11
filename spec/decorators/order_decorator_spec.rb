require 'rails_helper'

RSpec.describe OrderDecorator, type: :decorator do
  let(:food_items) { build_stubbed_list(:food_item, 3)}
  let(:order_decorator) { OrderDecorator.new(order) }
  let(:order) { build_stubbed(:order) }
  
  describe "#food_items_humanized" do
    it "returns list of food items in a sentance" do
      allow(order_decorator).to receive(:food_items).and_return(food_items)
      result = "#{food_items[0].name}, #{food_items[1].name}, #{food_items[2].name}"
      expect(order_decorator.food_items_humanized).to eql(result)
    end
  end

  describe "#formatted_created_at" do
    it "returns correctly fromatted created_at" do
      formatted_date = order.created_at.strftime("%d %b %Y")
      expect(order_decorator.formatted_created_at).to eql(formatted_date)
    end
  end

  describe "#todays_order?" do
    context "when order is created today" do
      it "returns true" do
        allow(order_decorator).to receive(:created_at).and_return(Time.now)
        expect(order_decorator.todays_order?).to be_truthy
      end
    end
    
    context "when order is not created today" do
      it "returns false" do
        allow(order_decorator).to receive(:created_at).and_return(1.day.ago)
        expect(order_decorator.todays_order?).to be_falsy
      end
    end
  end

  describe "#cost" do
    it "returns total cost of all food_items with currency symbol" do
      allow(order_decorator).to receive(:food_items).and_return(food_items)
      total_cost = food_items.pluck(:price).sum
      expect(order_decorator.cost).to eql("$#{total_cost}0")  
    end
  end

  describe "#confirmation_mail_title" do
    let(:user) { build_stubbed(:user) }
    it "returns sentance with confirmation and name" do
      allow(order_decorator).to receive(:user).and_return(user)
      message = "Hi #{user.name}! You got a new order for today from Lunch app!"
      expect(order_decorator.confirmation_mail_title).to eql(message)  
    end
  end
end
