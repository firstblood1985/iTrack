class BasicInfosController < ApplicationController
before_action :signed_in_user

	def new 
	@basic_info = BasicInfo.new
	respond_to do |format|
	  format.html 
      format.js
    end
	end

	def create
		current_user.basic_info=BasicInfo.new(basic_info_params)
		if current_user.basic_info.save
			flash[:success] = "basic info created!"
		else
			flash[:error] = "basic info create error!"
		end
	respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end

	end

	def update
		if current_user.basic_info.update_attributes(basic_info_params)
			flash[:success] = "basic info updated"
		else
			flash[:error] = "basic info update error!"
		end
		basic_info = current_user.basic_info
	respond_to do |format|
      format.html { redirect_to root_url }
      format.js
      format.json do
      	render json: {
      		date_of_birth:basic_info.date_of_birth,
      		height:basic_info.height,
      		weight:basic_info.weight,
      		bmi:basic_info.bmi
      	}.to_json
      end
    end
	
	end

	private 
	def basic_info_params
    	params.require(:basic_info).permit(:date_of_birth,:height,:weight)
  	end
end