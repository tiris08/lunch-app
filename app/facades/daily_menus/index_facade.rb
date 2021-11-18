module DailyMenus
  class IndexFacade
    include ActionView::Helpers
    include Rails.application.routes.url_helpers

    attr_reader :params, :current_user

    def initialize(params, current_user)
      @params = params
      @current_user = current_user
    end

    def paginated_daily_menus
      @paginated_daily_menus ||= DailyMenu.order(created_at: :desc).page(params[:page]).decorate
    end

    def active_unactive_menu_link(menu)
      if current_user
        make_order_or_history_link(menu)
      else
        content_tag(:button, 'History', class: 'ui bottom attached button',
                                                 'data-tooltip' => 'You have to sign in first')
      end
    end

    private

    def make_order_or_history_link(menu)
      if menu.created_at.today? && current_user.orders.find_by(daily_menu: menu).nil?
        link_to 'Make an order', new_daily_menu_order_path(menu),
                class: 'ui bottom attached blue button'
      else
        link_to 'History', daily_menu_path(menu), class: 'ui bottom attached button'
      end
    end
  end
end
