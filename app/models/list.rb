class List < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  validates :subject, presence: true
end
