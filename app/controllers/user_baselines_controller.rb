class UserBaselinesController < ApplicationController
before_action :signed_in_user

def create
	@user_baseline = current_user.user_baselines.build(user_baselines_params)
	if @user_baseline.save
			#@num = current_user.today_punch.number
			@baseline = Baseline.where(id: @user_baseline.baseline_id).first
			flash[:success] = "Performed #{@user_baseline.perf} #{@user_baseline.perf_additional} \
			on #{@baseline.name}, Nice job done!"
		else
			flash[:error] = "Create user_baseline Error.."
		end
	respond_to do |format|
      format.html { redirect_to root_url }
      format.js
 	end
end

def destroy

end

private 
	def user_baselines_params
    	params.require(:user_baseline).permit(:perf_date,:perf,:perf_additional,:baseline_id)
  	end
end