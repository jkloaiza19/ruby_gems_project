# frozen_string_literal: true

# It's a User class that has a role, and can have many courses
class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  validate :must_have_a_role, on: :update
  extend FriendlyId
  friendly_id :email, use: :slugged
  has_many :courses, dependent: :destroy

  def to_s
    email
  end

  def username
    email.spli(/@/).first
  end

  def assign_default_role
    add_role(:student) if roles.blank?
    add_role(:teacher)
  end

  def online?
    updated_at > 1.minutes.ago
  end

  private

  def must_have_a_role
    errors.add(:roles, 'must have at least one role') unless roles.any?
  end
end
