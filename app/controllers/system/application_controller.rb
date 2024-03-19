# frozen_string_literal: true

module System
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
    before_action :redirect_user

    layout 'system'

    private

    def redirect_user
      return unless user_signed_in? && !current_user.admin? && !devise_controller?

      flash[:error] = 'You do not have permission to go to administrative pages!'

      redirect_to authenticated_root_path
    end
  end
end
