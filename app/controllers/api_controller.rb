class ApiController < ApplicationController
  include Knock::Authenticable
  undef_method :current_user

  skip_before_action :authenticate_user!
  before_action :authenticate_user
end