class Admin::UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_is_admin?
  end

  def show?
    user_is_admin?
  end

  private

  def user_is_admin?
    @user.is_admin?
  end
end
