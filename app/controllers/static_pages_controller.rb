class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@micropost = current_user.microposts.build 
  		@feed_items = current_user.feed.paginate(page:params[:page]) 
  		unless current_user.basic_info.nil?
  		@basic_info = current_user.basic_info 
  		@bmi = @basic_info.bmi 
      @baselines = Baseline.all
      @records= current_user.user_baselines.all(order: "perf_date DESC")
  		end
  	end
  end

  def help
  end
  def about
  end
end
