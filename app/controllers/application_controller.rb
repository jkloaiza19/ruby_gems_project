class ApplicationController < ActionController::Base
    before_action :set_global_variables, if: :user_signed_in?

    ##
    # It sets the global variable @ransack_courses to the search results of the Course model.
    def set_global_variables
      @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
    end

    ##
    # It checks if the Authorization header is present and if it is, it returns the token
    def get_header_access_token
        (request.headers['Authorization'] =~ /^bearer\s./).present? ? request.headers['Authorization'].split(' ').last : nil
    end

    ##
    # > It gets the access token from the header, and then verifies it using the Firebase Authenticator
    def autorized_user?
        token = get_header_access_token

        raise "Unauthorized" unless token

        Firebase::Authenticator.verify_token(token)
    end
end
