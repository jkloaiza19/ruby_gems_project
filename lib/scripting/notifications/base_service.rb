# frozen_string_literal: true

module Notifications
  # It's a base class that can be inherited by other classes to provide a common interface for calling
  # the class
  class BaseService
    attr_reader :user_emails

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      puts args
      @user_emails = args[:user_emails]
    end

    # to be imlemented by the child class
    def call; end
  end
end
