class Course < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    validates :title, presence: true, length: { minimum: 8, maximum: 250 }
    validates :short_description, :price, :level, :language, presence: true
    validates :description, presence: true

    scope :recent, -> { order(created_at: :desc) }
    scope :by_title, -> (title) { where('title ILIKE ?', "%#{title}%") }

    has_rich_text :description
    belongs_to :user
end
