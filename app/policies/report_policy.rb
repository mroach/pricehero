class ReportPolicy < ApplicationPolicy
  def create?
    super || any_role?(:reporter, :editor)
  end
end
