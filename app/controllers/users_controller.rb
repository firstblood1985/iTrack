require 'pp'
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index,:edit, :update,:destroy,:following, :followers,:punch_history] #for authentication
  before_action :correct_user, only:[:edit, :update] #for authorization
  before_action :admin_user, only:[:destroy]
  def new
  	@user= User.new
  end
  def show 
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page:params[:page])
  end
  def create
  	@user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to iTrack"
      redirect_to @user 
    else
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
      #@users = User.all
      @users = User.paginate(page: params[:page])
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "User #{@user.name} destroyed."
      redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  def punch_history_week
    @user = User.find(params[:id])
    @start = params[:start]
    @end = params[:end]
    punch_history = @user.punches.where("punch_date > ? AND punch_date < ?",@start.to_i.week.ago,@end.to_i.week.ago).order(punch_date: :asc).load.map do |p|
        {punch_date:p.punch_date, number:p.number}
     end

    respond_to do |format|
      format.json do
        render json:  punch_history.to_json
        end
    end
  end
  def punch_history
    @user = User.find(params[:id])
    punch_history = @user.punches.load.map do |p|
        {punch_date:p.punch_date, number:p.number}
     end

    respond_to do |format|
      format.json do
        render json:  punch_history.to_json
        end
    end
  end

  def user_baselines
    @user = User.find(params[:id])
    @baseline_id = params[:baseline_id]
    user_baseline_history = @user.user_baselines.where("baseline_id = ? ", @baseline_id.to_i).order("perf_date ASC").load.map do |p|
      {perf_date:p.perf_date, perf:p.perf, perf_additional:p.perf_additional }
    end
    respond_to do |format|
    format.json do
        render json:  user_baseline_history.to_json
        end
    end  
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


    def correct_user
     @user = User.find(params[:id])      
     redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
