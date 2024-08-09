class Student < ApplicationRecord
  belongs_to :teacher
  has_many :subjects, dependent: :destroy

  accepts_nested_attributes_for :subjects, allow_destroy: true
end
