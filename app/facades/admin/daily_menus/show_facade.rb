module Admin
  module DailyMenus
    class ShowFacade
      include ActionView::Helpers

      attr_reader :daily_menu

      def initialize(daily_menu)
        @daily_menu = daily_menu
      end

      def orders_size
        @orders_size ||= daily_menu.orders.size
      end

      def total_sold
        @total_sold ||= number_to_currency(daily_menu.orders.includes(:food_items).pluck(:price).sum)
      end

      def menu_orders
        @menu_orders ||= daily_menu.orders.decorate
      end

      def most_popular_first_course
        @most_popular_first_course ||= OrderItem.includes(:food_item).where(food_item: { daily_menu: daily_menu, 
                                                          course: 'first_course' }).group(:food_item)
                                                                                   .count
                                                                                   .max_by { |k, v| v }
                                                                                   &.first
                                                                                   &.name
      end
      
      def most_popular_main_course
        @most_popular_main_course ||= OrderItem.includes(:food_item).where(food_item: { daily_menu: daily_menu, 
                                                          course: 'main_course' }).group(:food_item)
                                                                                  .count
                                                                                  .max_by { |k, v| v }
                                                                                  &.first
                                                                                  &.name
      end
      
      def most_popular_drink
        @most_popular_drink ||= OrderItem.includes(:food_item).where(food_item: { daily_menu: daily_menu, 
                                                          course: 'drink' }).group(:food_item)
                                                                            .count
                                                                            .max_by { |k, v| v }
                                                                            &.first
                                                                            &.name
      end
    end
  end
end
