# frozen_string_literal: true

class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :favorite_lists
  has_many :favorited_by, through: :favorite_lists, source: :user

  validates :user, presence: true
  validates :subject, presence: true

  after_update :destroy_favorite_lists

  scope :publicly_accessible, -> { where(public_access: true) }

  def owned_by?(user)
    self.user == user
  end

  def favorited_by?(user)
    favorite_lists.exists?(user: user)
  end

  private

    def destroy_favorite_lists
      if public_access_changed? && !public_access?
        favorite_lists.destroy_all
      end
    end
end
