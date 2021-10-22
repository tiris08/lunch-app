require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'guest' do 

    scenario 'signs up with name, email, and password' do
      visit root_path
      find('.ui.menu').click_link('Sign up')
      fill_in "Full Name",	with: "Example Examle" 
      fill_in "Email",	with: "example@gmail.com"
      fill_in "Password",	with: "password"
      fill_in "Password confirmation",	with: "password"
      click_button 'Sign up'
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario 'can`t sign up with unvalid data' do 
      visit root_path
      find('.ui.menu').click_link('Sign up')
      fill_in "Full Name",	with: "" 
      fill_in "Email",	with: "ivanyuk"
      fill_in "Password",	with: "123"
      fill_in "Password confirmation",	with: "234"
      click_button 'Sign up'
      expect(page).to have_content("4 errors prohibited this user from being saved")
    end

    scenario "logs in with email and password" do
      create(:user, email: "example@gmail.com", password: "password")
      visit root_path
      find('.ui.menu').click_link('Log in')
      fill_in "Email",	with: "example@gmail.com"
      fill_in "Password",	with: "password"
      click_button 'Log in'
      expect(page).to have_content("Signed in successfully.")
    end

    scenario "becomes an admin as a first registered user" do
      visit root_path
      find('.ui.menu').click_link('Sign up')
      fill_in "Full Name",	with: "Example Examle" 
      fill_in "Email",	with: "example@gmail.com"
      fill_in "Password",	with: "password"
      fill_in "Password confirmation",	with: "password"
      click_button 'Sign up'
      expect(page).to have_current_path(admin_root_path)
    end
  end

  describe "user" do
    
    let!(:user) { create(:random_user) }
    let!(:food_items_attributes) { attributes_for_list(:food_item, 3)}
    let!(:menu1) { create(:daily_menu, created_at: 2.day.ago, food_items_attributes: food_items_attributes) }
    let!(:menu2) { create(:daily_menu, created_at: 1.day.ago, food_items_attributes: food_items_attributes) }
    let!(:menu3) { create(:daily_menu, food_items_attributes: food_items_attributes) }
    before do
      user.update(is_admin: false)
      sign_in(user)
    end

    scenario "edits his profile" do
      visit root_path
      click_link('Settings')
      fill_in "Email",	with: "example@gmail.com"
      fill_in "Current password",	with: "password"
      click_button('Update')
      expect(page).to have_content("Your account has been updated successfully.")
    end
    
    scenario "can see weekdays on the home page" do
      visit root_path
      expect(page).to have_content(menu1.created_at.strftime('%A'))
      expect(page).to have_content(menu2.created_at.strftime('%A'))
      page.assert_selector('.ui.link.card', count: 3)
    end
    
    scenario "can see the menu list of items for the particular day" do
      create(:food_item, daily_menu: menu1, name: 'Chicken')
      visit root_path
      find('.ui.link.card', text: menu1.created_at.strftime('%A')).click_link('History')
      expect(page).to have_content("Menu list")
      expect(page).to have_content("Chicken")
    end

    scenario "can see his ordes" do
      pizza = create(:food_item, daily_menu: menu1, name: 'Pizza')
      order = build(:order, daily_menu: menu1, user: user)
      order.order_items.build(food_item: pizza)
      order.save
      visit root_path
      click_link 'My orders'
      click_link(I18n.l order.created_at)
      within('.column', text: 'Your order', match: :first) do
        page.assert_text('Pizza')
        page.assert_text('Order items')
      end
    end
  end

  describe "admin" do

    let!(:admin) { create(:user) }
    let!(:users) { create_list(:random_user, 10)}
    let!(:food_items_attributes) { attributes_for_list(:food_item, 3)}
    let!(:menu1) { create(:daily_menu, created_at: 2.day.ago, food_items_attributes: food_items_attributes) }
    let!(:menu2) { create(:daily_menu, created_at: 1.day.ago, food_items_attributes: food_items_attributes) }
    
    before do
      sign_in(admin)
    end

    scenario "can see list of registered users on the users page" do 
      visit root_path
      click_link('Users')
      10.times do |i|
        page.assert_selector('td', text: users[i].name)
      end
    end

    scenario "can see user`s profile on the user profile page" do 
      visit root_path
      click_link('Users')
      click_link(users[0].name)
      page.assert_selector('.ui.header', text: 'User info')
      page.assert_text(users[0].name)
      page.assert_text(users[0].email)
    end

    scenario "can see weekdays on the home page" do
      visit root_path
      page.assert_selector('.ui.link.card', count: 2)
      expect(page).to have_content(menu1.created_at.strftime('%A'))
      expect(page).to have_content(menu2.created_at.strftime('%A'))
    end

    scenario "can see the menu list day page", js: true do
      create(:food_item, daily_menu: menu1, name: 'Chicken')
      visit root_path
      find('.ui.link.card', match: :first).click_link("History")
      find('.item', text: 'Menu list').click
      page.assert_selector('.item.active', text: 'Menu list')
      page.assert_text('Chicken')
    end

    scenario "can see users orders on the day page", js: true do
      chicken = create(:food_item, daily_menu: menu1, name: 'Chicken')
      order = build(:order, daily_menu: menu1, user: users[0])
      order.order_items.build(food_item: chicken)
      order.save
      visit root_path
      find('.ui.link.card', match: :first).click_link("History")
      find('.item', text: 'Users orders').click
      page.assert_selector('.item.active', text: 'Users orders')
      page.assert_text('Chicken')
      page.assert_text(users[0].name)
    end

    scenario "can see statistics of the day on the day page" do
      create(:food_item, daily_menu: menu1, name: 'Chicken')
      visit root_path
      find('.ui.link.card', match: :first).click_link("History")
      page.assert_selector('th', text: 'Most popular menu items', :visible => true)
      page.assert_selector('td', text: 'Chicken', :visible => true)
    end
  end
end