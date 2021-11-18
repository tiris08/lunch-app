require 'rails_helper'

RSpec.feature 'DailyMenu', type: :feature do
  describe 'admin' do
    let!(:admin) { create(:user) }

    before do
      sign_in(admin)
    end

    scenario 'creates a new menu', js: true do
      visit admin_root_path
      click_link('Create a menu for today')
      fill_in 'Name', with: 'Pizza'
      fill_in 'Price', with: 4
      page.choose('First', allow_label_click: true)
      click_button('Create')
      page.assert_text('Menu created!')
    end

    scenario 'cannot create a new manu with invalid data', js: true do
      visit admin_root_path
      click_link('Create a menu for today')
      fill_in 'Name', with: ''
      fill_in 'Price', with: 2
      click_button('Create')
      page.assert_text("can't be blank")
    end

    scenario 'updates existing menu items', js: true do
      food_items_attributes = attributes_for_list(:food_item, 3)
      create(:daily_menu, food_items_attributes: food_items_attributes)
      visit admin_root_path
      click_link('Edit a menu for today')
      fill_in 'Name', with: 'Pizza', match: :first
      click_button('Update')
      page.assert_text('Menu updated!')
      find('.item', text: 'Menu list').click
      page.assert_text('Pizza')
    end

    scenario 'adds new items to the menu', js: true do
      food_items_attributes = attributes_for_list(:food_item, 3)
      create(:daily_menu, food_items_attributes: food_items_attributes)
      visit admin_root_path
      click_link('Edit a menu for today')
      click_link('Add item')
      within(:xpath, '//*[@id="food_items"]/div/div[1]/div') do
        fill_in 'Name', with: 'Pizzza'
        fill_in 'Price', with: 6
        page.choose('First', allow_label_click: true)
      end
      click_button('Update')
      page.assert_text('Menu updated!')
      find('.item', text: 'Menu list').click
      page.assert_text('Pizzza')
    end

    scenario 'removes existing menu items', js: true do
      food_items_attributes = attributes_for_list(:food_item, 3)
      create(:daily_menu, food_items_attributes: food_items_attributes)
      visit admin_root_path
      click_link('Edit a menu for today')
      click_link('Remove item', match: :first)
      click_button('Update')
      page.assert_text('Menu updated!')
      find('.item', text: 'Menu list').click
      page.assert_selector('.ui.header', count: 2)
    end
  end
end
