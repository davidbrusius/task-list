class FavoriteList < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :user, :list, presence: true
  validates :user, uniqueness: { scope: :list_id }
  validate  :list_is_public

  private
  def list_is_public
    if list.present?
      errors.add(:list, 'is not publicly accessible') unless list.public_access?
    end
  end
end
