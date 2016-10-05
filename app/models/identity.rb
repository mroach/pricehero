# An oauth identity. These allow users to have more than one oauth provider
# Identities belong to users and must be unique. A user can only have one ident
# per provider and a given provider and uid combo can only exist once
class Identity < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :user
  validates :uid, presence: true
  validates :provider, presence: true, uniqueness: { scope: :user_id }
  validates :uid, uniqueness: { scope: :provider, case_sensitive: false }

  def self.find_by_oauth(auth)
    find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |ident|
      ident.info = auth.info
    end
  end
end
