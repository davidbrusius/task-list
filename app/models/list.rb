class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :subject, presence: true
end
