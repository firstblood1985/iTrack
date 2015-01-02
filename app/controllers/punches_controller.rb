class PunchesController < ApplicationController
before_action :signed_in_user
	def create
		if current_user.punch(Punch.new(punch_params))
			@num = current_user.today_punch.number
			flash[:success] = "Punched #{@num} km today, Nice job done!"
		else
			flash[:error] = "Punch Error.."
		end
	respond_to do |format|
      #format.html { redirect_to root_url }
      format.js
 	end
 	end

 	def update

 	end
 	def destroy
 	current_user.un_punch
 	respond_to do |format|
      #format.html { redirect_to root_url, status: :see_other}
      format.js
 	end
 	end


	private 
	def punch_params
    	params.require(:punch).permit(:punch_date,:number)
  	end
end
