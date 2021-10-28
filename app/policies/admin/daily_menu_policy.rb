class Admin::DailyMenuPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_is_admin?
  end

  def new?
    user_is_admin?
  end

  def create?
    user_is_admin?
  end

  def show?
    user_is_admin?
  end

  def edit?
    user_is_admin?
  end

  def update?
    user_is_admin?
  end
end
