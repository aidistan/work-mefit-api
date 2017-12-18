class MeasurementPolicy < ApplicationPolicy
  def show?
    user.has_role?(:_staff_) ||
      (user.has_role?(:user) && user == record.user)
  end

  def create?
    user.has_role?(:_staff_) ||
      (user.has_role?(:user) && user == record.user)
  end

  def update?
    user.has_role?(:_staff_) ||
      (user.has_role?(:user) && user == record.user)
  end

  def destroy?
    user.has_role?(:_staff_) ||
      (user.has_role?(:user) && user == record.user)
  end

  class Scope < Scope
    def resolve
      if user.has_role? :_staff_
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
