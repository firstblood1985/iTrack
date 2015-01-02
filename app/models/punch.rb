class Punch < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence:true 
	validates_date :punch_date, :on_or_before => lambda { Date.current }
	validates :number, presence:true 

end
