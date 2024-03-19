# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    if resource.role == 'admin'
      admin_root_path
    elsif resource.role == 'user'
      authenticated_root_path
    else
      root_path
    end
  end
end
