class User < ActiveRecord::Base
	has_secure_password
	validates :email, presence: true, email: true, uniqueness: true
	validates :password, presence: true, confirmation: true, length: { minimum: 5 }
end
