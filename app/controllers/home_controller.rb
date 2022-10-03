class HomeController < ApplicationController
    before_action :authenticate_user!, :except => [:index]

    def index
        @latest_courses = Course.last(3)
        @courses = Course.all
        @users = User.all
    end
end
