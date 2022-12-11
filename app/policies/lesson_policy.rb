# frozen_string_literal: true

# The scope is all records, and only admins and teachers can create lessons, and only admins and the
# lesson's owner can update, edit, and destroy lessons.
class LessonPolicy < ApplicationPolicy
  # This class is a scope that returns all records.
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def edit?
    owner_or_admin?
  end

  def new?
    admin_or_teacher?
  end

  def create?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  def admin_or_teacher?
    @user.has_role?(:admin) || @user.has_role?(:teacher)
  end

  def owner_or_admin?
    @user.has_role?(:admin) || @record.course.user == @user
  end
end
