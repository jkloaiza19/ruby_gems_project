# frozen_string_literal: true

# We're creating a new table called lessons, and it has a title, content, and a reference to a course
class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :content
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
