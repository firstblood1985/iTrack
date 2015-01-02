class User < ActiveRecord::Base
	validates :name, presence: true, length: {maximum:30, minimum:3}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
	before_save { self.email = email.downcase}
	validates :password, length: { minimum: 6 }
	has_secure_password
	before_create :create_remember_token
	#can respond to microposts
	has_many :microposts,dependent: :destroy
	#can respond to relationships
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	#can respond to followed_users, can be has_many :followeds, through: :relationships
	#however, 'followeds' is not english, can use source to deligate to followed
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	has_one :basic_info, dependent: :destroy
	has_many :punches, dependent: :destroy

	has_many :baselines, through: :user_baselines, uniq: true
	has_many :user_baselines, dependent: :destroy

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.hash(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

	def feed
		 Micropost.from_users_followed_by(self)
	end	

	def following?(other_user)
		followed_users.include?(other_user)
		#relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id:other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end
	def punch(arg)
    	unless self.punched_today?
    		punch = if(arg.is_a?(Punch))
    				if(!punched_on?(arg.punch_date))
    		 		self.punches.build(punch_date:arg.punch_date,number:arg.number)
    		 		else
    		 		nil	
    		 		end
    				else
					self.punches.build(punch_date:Date.current,number:arg)
					end
			punch.save! unless punch.nil?
		end
	end
	def punched_on?(date)
		self.punches.any? {|punch| punch.punch_date == date}
	end
	def punched_today?
		self.punches.any? {|punch| punch.punch_date == Date.current}
	end
	def today_punch 
		if punched_today?
			p = self.punches.find {|punch| punch.punch_date == Date.current}
		else 
			Punch.new	
		end

	end
	def un_punch
		if punched_today?
			p = self.punches.find {|punch| punch.punch_date == Date.current}
			p.destroy!
		end
	end
	private 
	def create_remember_token
		self.remember_token = User.hash(User.new_remember_token)
	end
end
