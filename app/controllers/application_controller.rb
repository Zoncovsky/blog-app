# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    if resource.role == 'admin'
      admin_root_path
    elsif resource.role == 'user'
      main_posts_path
    else
      root_path
    end
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'

    redirect_back(fallback_location: admin_root_path)
  end
end
