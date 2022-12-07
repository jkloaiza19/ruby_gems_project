# frozen_string_literal: true

namespace :notifications do
  namespace :user_notifications do
    desc 'Sends notifications to users'
    # Example: rake notifications:user_notifications:create\['burrilia@test.com jkloaiza19+ruby@gmail.com'\]
    task :create, [:user_emails] => :environment do |_t, args|
      arg_hash = args.to_hash
      parsed_user_emails = arg_hash[:user_emails]&.split(' ')&.map(&:to_s)

      Notifications::NotificationCreator.call(user_emails: parsed_user_emails)
    end
  end
end
