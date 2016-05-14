class List < ActiveRecord::Base
  validates :subject, presence: true
end
