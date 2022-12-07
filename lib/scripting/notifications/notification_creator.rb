# frozen_string_literal: true

module Notifications
  # This class is responsible for creating notifications for users.
  class NotificationCreator < BaseService
    def call
      process_notifications
    end

    def process_notifications
      User.where(email: user_emails).find_in_batches(batch_size: 10) do |group|
        sleep(10)
        group.each { |user| send_notification(user) }
      end
    end

    def send_notification(user)
      puts 'Implementation will be added soon'
      puts user
    rescue StandardError => e
      puts e.class
    end
  end
end
