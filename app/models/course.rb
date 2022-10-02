class Course < ApplicationRecord
    validates :title, presence: true, length: { minimum: 8, maximum: 250 }
    validates :description, presence: true

    scope :recent, -> { order(created_at: :desc) }

    has_rich_text :description
end
