class AddUserToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :user_id, :int
  end
end
