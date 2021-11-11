require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:orders) }
  end
  
  describe "#set_admin" do
    it 'sets the first registered user to admin' do
      first_user = create(:random_user)
      second_user = create(:random_user)
      expect(first_user.is_admin?).to be_truthy
      expect(second_user.is_admin?).to be_falsy
    end
  end
end
