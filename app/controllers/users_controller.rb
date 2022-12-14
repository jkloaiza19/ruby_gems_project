# frozen_string_literal: true

# It's a controller that allows admins to manage users
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit destroy update]
  before_action :validate_admin

  def index
    # @users = User.all.order(created_at: :desc)
    @q = User.ransack(params[:q])
    # @users = @q.result(distinct: true)
    @pagy, @users = pagy(@q.result(distinct: true))
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit({ role_ids: [] }, :email)
  end
end
