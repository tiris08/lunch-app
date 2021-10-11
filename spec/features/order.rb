require 'rails_helper'

RSpec.feature 'order', type: :feature do
  
  describe "valid user" do
    let!(:admin) { create(:user) }
    let!(:user) { create(:random_user) }
    let!(:menu) { create(:daily_menu) }
    let!(:food_items) { create_list(:food_item, 6, daily_menu: menu) }
    let!(:first) {create(:food_item, daily_menu: menu, name: "example1", course: 0)}
    let!(:main) {create(:food_item, daily_menu: menu, name: "example2", course: 1)}
    let!(:drink) {create(:food_item, daily_menu: menu, name: "example3", course: 2)}
    
    scenario "Make a new order with all 3 courses", js: true do 
      visit root_path
      within find('.ui.menu') do
        click_link('Log in')
      end
      fill_in "Email",	with: user.email
      fill_in "Password",	with: "password"
      click_button 'Log in'
      click_link('Make an order')
      select(first.name,	from: 'First')
      select(main.name,	from: 'Main')
      select(drink.name,	from: 'Drink')
      click_button('Order')
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Your order was successfully created")
    end

    scenario "Fail to create a new order without food items", js: true do 
      visit root_path
      within find('.ui.menu') do
        click_link('Log in')
      end
      fill_in "Email",	with: user.email
      fill_in "Password",	with: "password"
      click_button 'Log in'
      click_link('Make an order')
      click_button('Order')
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Try again.")
    end

    scenario "update existent order", js: true do 
      order = build(:order, daily_menu: menu, user: user)
      3.times {order.order_items.build}
      order.order_items[0].food_item = first
      order.order_items[1].food_item = main
      order.order_items[2].food_item = drink
      order.save
      new_first = create(:food_item, daily_menu: menu, name: "whatever", course: 0)
      visit root_path
      within find('.ui.menu') do
        click_link('Log in')
      end
      fill_in "Email",	with: user.email
      fill_in "Password",	with: "password"
      click_button 'Log in'
      click_link 'History'
      click_link 'Edit'
      find(:xpath, '//*[@id="order_order_items_attributes_0_food_item_id"]').select(new_first.name)
      click_button('Confirm')
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Your order has been succesfully updated!")
    end

    scenario "delete existent order", js: true do 
      order = build(:order, daily_menu: menu, user: user)
      3.times {order.order_items.build}
      order.order_items[0].food_item = first
      order.order_items[1].food_item = main
      order.order_items[2].food_item = drink
      order.save
      visit root_path
      within find('.ui.menu') do
        click_link('Log in')
      end
      fill_in "Email",	with: user.email
      fill_in "Password",	with: "password"
      click_button 'Log in'
      click_link 'History'
      click_link 'Cancel my order'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Your order has been succesfully deleted")
    end
  end
end