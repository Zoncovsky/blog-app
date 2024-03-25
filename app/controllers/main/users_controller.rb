# frozen_string_literal: true

module Main
  class UsersController < Main::ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    def show
      authorize @user, :show?

      @user = User.find(params[:id])
    end

    def edit
      authorize @user, :edit?
    end

    def update
      authorize @user, :update?

      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to main_user_path(@user), notice: 'Your profile was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @user, :destroy?

      @user.destroy
      respond_to do |format|
        format.html { redirect_to unauthenticated_root_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(policy(User).permitted_attributes)
    end
  end
end
