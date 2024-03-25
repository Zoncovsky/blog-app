# frozen_string_literal: true

class ResourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all || scope.where(user:)
    end
  end

  def index?
    user.present?
  end

  def show?
    user.present? && (admin? || owner?)
  end

  def new?
    user.present?
  end

  def create?
    admin? || owner?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  protected

  def owner?
    user == record&.try(:user)
  end

  def admin?
    user.admin?
  end
end
