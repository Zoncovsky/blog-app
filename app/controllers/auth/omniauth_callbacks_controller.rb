# frozen_string_literal: true

module Auth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      authenticate_user('Google')
    end

    def github
      authenticate_user('Github')
    end

    private

    def authenticate_user(kind)
      auth_service = Authorization::AuthenticationService.new(request.env['omniauth.auth'])
      @user = auth_service.authenticate_user

      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind:)
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.auth_data'] = request.env['omniauth.auth'].except('extra')
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join('\n')
      end
    end
  end
end
