# frozen_string_literal: true

# The HomeController is a class that inherits from the ApplicationController class
class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :validate_admin, only: %i[activity]

  def index
    @latest_courses = Course.last(3)
    @courses = Course.all
    @users = User.all
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
