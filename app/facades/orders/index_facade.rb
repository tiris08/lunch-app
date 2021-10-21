module Orders
  class IndexFacade
    attr_accessor :current_user, :params

    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end
    
    def paginated_user_orders
      @paginated_user_orders = Order.where(user: current_user)
                                    .order(created_at: :desc)
                                    .page(params[:page])
                                    .per(12)
                                    .decorate
    end
  end
end
