require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  
  let(:user_decorator) { UserDecorator.new(user) }
  let(:user) { build_stubbed(:user, created_at: Time.now) }
  
  describe "#joined_in_date" do
    it "returns correctly fromatted created_at" do
      formatted_date = user.created_at.strftime("%d %b %Y")
      expect(user_decorator.joined_in_date).to eql(formatted_date)
    end
  end

  describe "#last_order_date" do
    context "when user has an order" do
      
      let(:order) { build_stubbed(:order, created_at: Time.now) }
      
      it "returns correctly formatted order.created_at" do
        allow(user_decorator).to receive(:orders).and_return([order])
        formatted_date = user.created_at.strftime("%d %b %Y")
        expect(user_decorator.last_order_date).to eql(formatted_date)
      end  
    end
    
    context "when user don\'t have an order" do
      
      let(:order) { build_stubbed(:order, created_at: Time.now) }
      
      it "returns message about order\'s absence" do
        allow(user_decorator).to receive(:orders).and_return([])
        expect(user_decorator.last_order_date).to eql("No orders yet")
      end   
    end    
  end
end
