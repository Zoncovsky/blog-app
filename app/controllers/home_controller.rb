# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @post = Post.where(user_id: 2).limit(2)
  end
end
