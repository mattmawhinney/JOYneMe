class User < ActiveRecord::Base

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	#password confirmation through input fields currently not working
	has_secure_password 
	#need to include :allow_nil options hash to allow for proper updating
	#otherwise creates problems with validating/password_digest
	validates_length_of   :password, :minimum => 2, :allow_nil => true

	validates_presence_of :username, :email
	validates_length_of   :username, :maximum => 30
	validates_format_of   :email, :with => EmailRegex
	# need to double check and make sure I am ignoring case in validating uniqueness
	validates_uniqueness_of :username, :email, :case_sensitive => false

	has_many :events
	has_many :attendees

	has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/




	
end
