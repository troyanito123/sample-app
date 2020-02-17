class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def new?
    if user
      if user.admin?
        true
      else
        false
      end
    else
      true
    end
  end

  def create?
    new?
  end

  def edit?
    puts record.inspect
    user.admin? || user == record
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end