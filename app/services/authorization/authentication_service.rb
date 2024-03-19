# frozen_string_literal: true

module Authorization
  class AuthenticationService
    def initialize(access_token)
      @access_token = access_token
    end

    def authenticate_user
      user = find_or_initialize_user
      save_user(user)
      user
    end

    private

    def find_or_initialize_user
      User.where(provider: @access_token.provider, uid: @access_token.uid).first_or_initialize do |u|
        u.email = @access_token.info.email
        u.password = Devise.friendly_token[0, 20]
        u.uid = @access_token.uid
        u.provider = @access_token.provider

        if @access_token.provider == 'google_oauth2'
          u.first_name = @access_token.info.first_name
          u.last_name = @access_token.info.last_name
          u.nickname = generate_nickname(@access_token.info.first_name, @access_token.info.last_name)
        elsif @access_token.provider == 'github'
          u.first_name, u.last_name = @access_token.info.name.split(' ', 2)
          u.nickname = @access_token.info.nickname
        end

        if @access_token.info.image.present?
          avatar_url = @access_token.info.image
          avatar = URI.open(avatar_url)
          u.avatar.attach(io: avatar, filename: 'avatar.jpg', content_type: 'image/jpg')
        end
      end
    end

    def save_user(user)
      user.save
    end

    def generate_nickname(first_name, last_name)
      "#{first_name.downcase}_#{last_name.downcase}_#{rand(1000)}"
    end
  end
end
