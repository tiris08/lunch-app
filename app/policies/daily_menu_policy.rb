class DailyMenuPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user_is_not_admin?
  end

  def index?
    user_is_not_admin?
  end
end
