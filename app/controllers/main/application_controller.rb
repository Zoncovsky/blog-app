# frozen_string_literal: true

module Main
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!

    layout 'main'
  end
end
