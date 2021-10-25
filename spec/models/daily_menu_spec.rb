require 'rails_helper'

RSpec.describe DailyMenu, type: :model do
  it { should accept_nested_attributes_for(:food_items).allow_destroy(true) }
  it { should have_many(:food_items) }
  it { should have_many(:orders) }
end
