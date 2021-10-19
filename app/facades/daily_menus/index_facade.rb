module DailyMenus
  class IndexFacade
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def paginated_daily_menus
      @daily_menus ||= DailyMenu.order(created_at: :desc).page(params[:page]).decorate
    end
  end
end
