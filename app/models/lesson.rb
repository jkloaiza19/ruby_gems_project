# frozen_string_literal: true

class Lesson < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :content
  belongs_to :course

  validates :title, :content, presence: true
end
