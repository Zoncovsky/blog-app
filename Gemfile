# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'aasm'
gem 'bootsnap', require: false
gem 'brakeman', '~> 6.1'
gem 'bundler-audit', '~> 0.9.1'
gem 'chartkick'
gem 'config'
gem 'devise', '~> 4.9'
gem 'enumerize'
gem 'fasterer', '~> 0.11.0'
gem 'groupdate'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'omniauth'
gem 'omniauth-github', '~> 2.0.0'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy', '~> 6.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.3'
gem 'rails', '7.1.3.1'
gem 'ransack'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails', '~> 2.3'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'rails_live_reload'
  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end
