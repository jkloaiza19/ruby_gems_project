class UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def index
         # @users = User.all.order(created_at: :desc)
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end

    def show
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end
