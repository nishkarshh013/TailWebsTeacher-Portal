class Subject < ApplicationRecord
  belongs_to :student

  validates :name, presence: true
  validates :marks, numericality: { less_than_or_equal_to: 100, message: "should be less than or equal to 100" }
end
