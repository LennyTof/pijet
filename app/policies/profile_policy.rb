class ProfilePolicy < ApplicationPolicy
  def show?
    record == user
  end
end
