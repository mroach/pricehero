class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    user.present? && (user.admin? || user.superuser?)
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.admin? || user.superuser?)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (user.admin? || user.superuser?)
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  protected

  def any_role?(*roles)
    user.present? && roles.map(&:to_sym).include?(user.role.to_sym)
  end
end
