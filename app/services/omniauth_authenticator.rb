# Service object to handling authentication from OmniAuth to slim-down the
# controller. Handles the finding or creation of People, Accounts, and Identities
# from an omniauth response
class OmniauthAuthenticator
  # auth: Comes from the request.env['omniauth.auth']
  def initialize(auth)
    @auth = auth
  end

  def persist_user!
    user.identities.push identity

    # Calling save on user will persist the person as well
    user.save!
  end

  def new_identity?
    !identity.persisted?
  end

  def identity
    @identity ||= Identity.find_by_oauth(@auth)
  end

  # Tries to find a person record with an email address matching the one
  # returned from the omniauth provider. If none was found, a new person is
  # initialised with the basic information from the provider
  def user
    @user ||= User.find_or_initialize_by email: @auth.info.email do |user|
      user.name = @auth.info.name
      user.nickname = @auth.info.name.downcase.split(/\W/).join('.')
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
