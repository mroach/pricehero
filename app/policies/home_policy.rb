class HomePolicy < Struct.new(:user, :home)
  def initialize(user, scope)
    @user  = user
    @scope = scope
  end

  def show?
    true
  end
end
