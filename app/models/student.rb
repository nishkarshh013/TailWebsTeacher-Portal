class Student < ApplicationRecord
  belongs_to :teacher
  has_many :subjects, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :subjects, allow_destroy: true

  before_create :normalize_name

  private

  def normalize_name
    self.name = self.name.strip.downcase if self.name.present?
  end
end
