# A place where one could perhaps find a product
class Store < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid
  has_paper_trail
  friendly_id :combined_name, use: :slugged

  has_many :reports

  validates :name, presence: true

  default_scope -> { order('name') }

  def combined_name
    [name, locality, state_province].join(' ')
  end

  def to_s
    combined_name
  end
end
