module DailyMenus
  class IndexFacade
    attr_reader :params
    
    def initialize(params)
      @params = params
    end

    def paginated_daily_menus
      DailyMenu.order(created_at: :desc).page(params[:page])
    end
  end
end
