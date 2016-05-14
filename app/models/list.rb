class List < ActiveRecord::Base
  has_many :tasks

  validates :subject, presence: true
end
