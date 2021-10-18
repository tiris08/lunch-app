module Admin
  module DailyMenus
    class IndexFacade
      include ActionView::Helpers
      include Rails.application.routes.url_helpers  
      
      attr_reader :params
      
      def initialize(params)
        @params = params
      end

      def paginated_daily_menus
        DailyMenu.order(created_at: :desc).page(params[:page])
      end

      def edit_or_create_menu_link
        if DailyMenu.last.created_at.today?
          link_to "Edit a menu for today ", edit_admin_daily_menu_path(DailyMenu.last), class: "ui primary large button"
        else
          link_to "Create a menu for today", new_admin_daily_menu_path, class: "ui primary large button" 
        end
      end
    end
  end
end
