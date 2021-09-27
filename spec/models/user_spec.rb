require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should have_many(:orders) }
  
  it "sets the first registered user to admin" do
    first_user = create(:random_user)  
    second_user = create(:random_user)
    expect(first_user.is_admin?).to be_truthy  
    expect(second_user.is_admin?).to be_falsy
  end
  
end
