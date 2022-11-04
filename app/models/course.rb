# It creates a class called Course that inherits from ApplicationRecord.
class Course < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true, length: { minimum: 8, maximum: 250 }
  validates :short_description, :price, :level, :language, presence: true
  validates :description, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }

  has_rich_text :description
  belongs_to :user

  LANGUAGES = %i[English Spanish French German Italian]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = %i[Beginner Intermediate Advanced]
  def self.levels
    LEVELS.map { |level| [level, level] }
  end
end
