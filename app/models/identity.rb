class Identity < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :user
  validates :uid, presence: true
  validates :provider, presence: true
  validates :uid, uniqueness: { scope: :provider, case_sensitive: false }

  def self.find_by_oauth(auth)
    find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |ident|
      ident.info = auth.info
    end
  end
end
