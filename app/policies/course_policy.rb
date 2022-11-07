# A user can only update, edit, destroy, or create a course if they are an admin or the owner of the
# course.
class CoursePolicy < ApplicationPolicy
  # > This class is a Pundit policy class that defines the rules for the `Scope` model
  class Scope < Scope
    def resolve
      scope.all
    end
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
    admin_or_teacher?
  end

  def destroy?
    owner_or_admin?
  end

  def admin_or_teacher?
    @user.has_role?(:admin) || @user.has_role?(:teacher)
  end

  def owner_or_admin?
    @user.has_role?(:admin) || @record.user == @user
  end
end
