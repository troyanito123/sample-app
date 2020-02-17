class CommentPolicy < ApplicationPolicy

  def create?
    user.normal_user? || user.admin?
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