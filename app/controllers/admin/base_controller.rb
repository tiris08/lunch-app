class Admin::BaseController < ApplicationController
  # pundit
  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end
