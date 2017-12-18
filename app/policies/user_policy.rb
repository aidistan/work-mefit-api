class UserPolicy < ApplicationPolicy
  def show?
    user.has_role?(:_staff_) ||
      (user.has_role?(:user) && user == record)
  end

  def update?
    user.has_role?(:_staff_) ||
      (user.has_role?(:user) && user == record)
  end
end
