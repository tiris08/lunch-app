module Admin
  module Users
    class IndexFacade
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def paginated_users
        @paginated_users ||= User.page(params[:page]).per(12).decorate
      end
    end
  end
end
