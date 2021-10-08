require 'rails_helper'

RSpec.feature 'DailyMenu', type: :feature do
  describe "admin" do
    
    let!(:admin) { create(:user) }
    
    before do
      sign_in(admin)  
    end

    scenario "creates a new menu", js: true do
      visit admin_root_path
      click_link('Create a menu for today')
      fill_in "Name", with: "Pizza"
      fill_in "Price", with: 4  
      page.choose('First',  allow_label_click: true)
      click_button('Create')
      page.assert_text('Menu created!')
    end
    
    scenario "cannot create a new manu with invalid data", js: true do
      visit admin_root_path
      click_link('Create a menu for today')
      fill_in "Name", with: ""
      fill_in "Price", with: 2 
      click_button('Create')
      page.assert_text("can't be blank")
    end
    
    scenario "updates existing menu items", js: true do
      menu = create(:menu_with_items)
      visit admin_root_path
      click_link('Edit a menu for today')
      fill_in "Name", with: "Pizza", match: :first
      click_button("Update")
      page.assert_text("Menu updated!")
      find('.item', text: 'Menu list').click
      page.assert_text("Pizza")
    end

    scenario "adds new items to the menu", js: true do
      menu = create(:menu_with_items)
      visit admin_root_path
      click_link('Edit a menu for today')
      click_link('Add item')
      within all('.input.string.required.daily_menu_food_items_name').last do 
        fill_in "Name", with: "Pizzza"
      end
      within all('.input.decimal.required.daily_menu_food_items_price').last do 
        fill_in "Price", with: 6
      end
      within all('.input.radio_buttons.required.daily_menu_food_items_course').last do 
        page.choose('First',  allow_label_click: true)
      end
      click_button("Update")
      page.assert_text("Menu updated!")
      find('.item', text: 'Menu list').click
      page.assert_text("Pizzza")
    end

    scenario "removes existing menu items", js: true do
      menu = create(:menu_with_items, items_count: 6)
      visit admin_root_path
      click_link('Edit a menu for today')
      click_link('Remove item', match: :first)
      click_button("Update")
      page.assert_text("Menu updated!")
      find('.item', text: 'Menu list').click
      page.assert_selector('.ui.header', count: 5)
    end
  end
end