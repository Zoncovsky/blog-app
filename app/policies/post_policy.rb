# frozen_string_literal: true

class PostPolicy < ResourcePolicy
  def edit?
    update?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  def permitted_attributes
    %i[
      note
      status
      images
      user_id
    ]
  end

  private

  def owner?
    user.present? && user == record&.user
  end
end
