class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :user, presence: true
  validates :subject, presence: true

  scope :publicly_accessible, -> { where(public_access: true) }

  def owned_by?(user)
    self.user == user
  end
end
