# frozen_string_literal: true

class Task < ActiveRecord::Base
  belongs_to :list
  has_one :user, through: :list

  validates :list, presence: true
  validates :description, presence: true
end
