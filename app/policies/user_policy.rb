# frozen_string_literal: true

class UserPolicy < ResourcePolicy
  def index?
    admin?
  end

  def show?
    owner? || admin?
  end

  def edit?
    update?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  def redirect_user?
    user.role.user?
  end

  def permitted_attributes
    base_permitted_attributes << [:avatar]
  end

  def admin_permitted_attributes
    permitted_attributes << %i[role avatar]
  end

  private

  def base_permitted_attributes
    %i[
      first_name
      last_name
      nickname
      phone_number
      email
      password
      password_confirmation
    ]
  end

  def owner?
    user == record
  end
end
