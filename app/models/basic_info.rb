class BasicInfo < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence:true 
	validates_date :date_of_birth, :on_or_before => lambda { Date.current }
	validates :date_of_birth, presence:true
	validates :height, presence:true
	validates :weight, presence:true

	def bmi
=begin
BMI Categories: 
Underweight = <18.5
Normal weight = 18.5–24.9 
Overweight = 25–29.9 
Obesity = BMI of 30 or greater
BMI = (Weight in kilos)/(height in meters)^2
=end
	bmi = self.weight/((self.height/100.to_f)**2) #Metric Method
	format("%.2f",bmi).to_f
	end
end
