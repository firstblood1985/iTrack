class User < ActiveRecord::Base
	validates :name, presence: true, length: {maximum:30, minimum:3}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
	before_save { self.email = email.downcase}
	validates :password, length: { minimum: 6 }
	has_secure_password
	before_create :create_remember_token
	has_many :microposts,dependent: :destroy

	def feed
		microposts
	end	
	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.hash(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

	private 
	def create_remember_token
		self.remember_token = User.hash(User.new_remember_token)
	end
end
