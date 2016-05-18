class FavoriteList < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :user, :list, presence: true
end
