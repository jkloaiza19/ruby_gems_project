# frozen_string_literal: true

# It's a class that inherits from ActionController::Base and includes the
# PublicActivity::StoreController, Pundit::Authorization, and the before_action and after_action
# methods
class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Pundit::Authorization
  before_action :set_global_variables, if: :user_signed_in?
  after_action :update_user_online, if: :user_signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def validate_admin
    return if current_user.has_role? :admin

    redirect_to root_path
  end

  ##
  # It sets the global variable @ransack_courses to the search results of the Course model.
  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) # navbar search
  end

  ##
  # It checks if the Authorization header is present and if it is, it returns the token
  def header_access_token
    (request.headers['Authorization'] =~ /^bearer\s./).present? ? request.headers['Authorization'].split(' ').last : nil
  end

  ##
  # > It gets the access token from the header, and then verifies it using the Firebase Authenticator
  def autorized_user?
    token = header_access_token

    raise 'Unauthorized' unless token

    Firebase::Authenticator.verify_token(token)
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def update_user_online
    current_user.try :touch
  end
end
