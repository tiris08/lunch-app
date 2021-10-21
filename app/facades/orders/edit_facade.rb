module Orders
  class EditFacade
    attr_reader :order, :params

    def initialize(order, params)
      @order = order
      @params = params
    end

    def daily_menu
      @daily_menu ||= order.daily_menu.decorate
    end

    def food_items_collection(course)
      FoodItem.where(daily_menu_id: daily_menu_id, course: course)
    end

    def first_course_item
      @new_first_course_item ||= order.order_items.find_or_initialize_by(food_item: order.food_items
                                                                                           .find_by(course: 'first_course'))
    end

    def main_course_item
      @new_main_course_item ||= order.order_items.find_or_initialize_by(food_item: order.food_items
                                                                                        .find_by(course: 'main_course'))
    end

    def drink_item
      @new_drink_item ||= order.order_items.find_or_initialize_by(food_item: order.food_items
                                                                                  .find_by(course: 'drink'))
    end

    private

    def daily_menu_id
      @daily_menu_id ||= params[:daily_menu_id]
    end
  end
end
