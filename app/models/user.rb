class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable
  has_many :courses, dependent: :destroy
  validate :must_have_a_role, on: :update
  extend FriendlyId
  friendly_id :email, use: :slugged

  def to_s
    email
  end

  def username
    self.email.spli(/@/).first
  end

  def assign_default_role
    self.add_role(:student) if self.roles.blank?
    self.add_role(:teacher)
  end

  def online?
    updated_at > 1.minutes.ago
  end

  private

  def must_have_a_role
    errors.add(:roles, 'must have at least one role') unless roles.any?
  end
end
