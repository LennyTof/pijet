class RentalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user
  end

  def create?
    true
  end

  def accept?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
