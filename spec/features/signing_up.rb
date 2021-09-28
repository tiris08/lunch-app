require 'rails_helper'

RSpec.feature 'Signing up', type: :feature do
  context "guest" do
    before(:each) do
      create(:user)
      visit new_user_registration_path
    end
    scenario "successfully signs up" do
      within('form') do
        fill_in "Full Name",	with: "Taras Ivanyuk" 
        fill_in "Email",	with: "ivanyuk@gmail.com"
        fill_in "Password",	with: "password"
        fill_in "Password confirmation",	with: "password"
      end
      click_button 'Sign up'
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario "raises errors" do
      within('form') do
        fill_in "Full Name",	with: "Taras Ivanyuk" 
        fill_in "Email",	with: "ivanyukgmail.com"
        fill_in "Password",	with: "password"
        fill_in "Password confirmation",	with: "password"
      end
      click_button 'Sign up'
      expect(page).to have_content("prohibited this user from being saved")
    end

  end
  
end