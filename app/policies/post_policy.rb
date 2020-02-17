class PostPolicy < ApplicationPolicy

  def index?
    !user.nil?
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def edit?
    user.admin? || record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end