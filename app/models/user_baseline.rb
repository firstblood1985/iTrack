class UserBaseline < ActiveRecord::Base
	belongs_to :user
  	belongs_to :baseline

  	validates :user_id, presence: true
  	validates :baseline_id, presence: true
  	validates :perf, presence: true	
  	validates :perf_date, presence:true
end
