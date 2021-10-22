class CreateDailyMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_menus, &:timestamps
  end
end
