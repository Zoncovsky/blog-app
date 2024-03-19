# frozen_string_literal: true

module System
  class UsersController < ApplicationController
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action :set_user, only: %i[show edit update destroy]

    def index
      authorize User, :index?

      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true)
      @pagy, @users = pagy(@q.result)
    end

    def show
      authorize User, :show?

      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to system_user_path(@user), notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to system_user_path(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to system_users_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(policy(User).admin_permitted_attributes)
    end

    def default_sorts
      ['position asc']
    end

    def user_not_authorized
      flash[:alert] = 'Action for administrators only'

      redirect_back(fallback_location: admin_root_path)
    end
  end
end
