class SearchPolicy < Struct.new(:user, :search)
  attr_reader :user

  def initialize(user, scope)
    @user  = user
    @scope = scope
  end

  def multi?
    user.present?
  end
end
