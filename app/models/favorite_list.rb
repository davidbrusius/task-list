class FavoriteList < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :user, :list, presence: true
  validates :user, uniqueness: { scope: :list_id }
end
