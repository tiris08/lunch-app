require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  
  describe "associations" do
    it { should belong_to(:order)}
    it { should belong_to(:food_item) }
  end
end
