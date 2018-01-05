class AcquirementPolicy < ApplicationPolicy
  alias show? user_resource
  alias create? user_resource
  alias update? user_resource
  alias destroy? user_resource

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
