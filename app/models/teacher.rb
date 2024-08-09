class Teacher < ApplicationRecord
	has_secure_password
	has_many :students

	validates :username, presence: true, uniqueness: true
end
