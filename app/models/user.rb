class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable
  has_many :courses, dependent: :destroy

  def to_s
    email
  end

  def username
    self.email.spli(/@/).first
  end

  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end
end
