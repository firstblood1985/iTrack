class BaselinesController < ApplicationController
before_action :signed_in_admin
	def new 
	@baseline = Baseline.new
	respond_to do |format|
	  format.html 
      format.js
    end
	end
	def index
		@baselines = Baseline.all
	end

	def show 
		@baseline = Baseline.find(params[:id])
	end
	def create
		@baseline = Baseline.new(baseline_params)
		if @baseline.save
			flash[:success] = "new baseline created!"
			redirect_to @baseline
		else
			flash[:error] = "new baseline create error!"
		end
	end	


	private 
	def baseline_params
    	params.require(:baseline).permit(:name,:description,:baseline_type)
  	end
end	