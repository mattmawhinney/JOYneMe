class User < ActiveRecord::Base

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates_presence_of :username, :email, :password
	validates_length_of   :username, :maximum => 30
	validates_format_of   :email, :with => EmailRegex
	#need to double check and make sure I am ignoring case in validating uniqueness
	validates_uniqueness_of :username, :email, :case_sensitive => false



	has_many :events
	has_secure_password 
end
