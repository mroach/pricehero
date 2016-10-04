# Represents any user of the system. Authentication is oauth-only!
class User < ApplicationRecord
  extend FriendlyId

  has_paper_trail
  acts_as_paranoid
  friendly_id :nickname, use: :slugged

  devise :database_authenticatable, :rememberable, :omniauthable, omniauth_providers: [:facebook]

  enum role: %i(viewer editor admin)

  has_many :reports
  has_many :identities, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :nickname, presence: true

  # Ensure that email addresses are lowercase and have no whitespace padding
  def email=(value)
    self[:email] = value.try(:downcase).try(:strip)
  end
end
