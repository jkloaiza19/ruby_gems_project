# frozen_string_literal: true

# We're adding a column called slug to the lessons table, and we're making sure that the slug is
# unique
class AddSlugToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :slug, :string
    add_index :lessons, :slug, unique: true
  end
end
