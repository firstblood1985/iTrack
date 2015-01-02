require 'spec_helper'

describe BasicInfosController do
let(:user) { FactoryGirl.create(:user) }
let(:user_without_basic_info) { FactoryGirl.create(:user_without_basic_info) }

  describe "create basic info with post" do
  	

  	before { sign_in user_without_basic_info, no_capybara: true }
  	#capybara simulates user interaction with browser, however at controller level, no browser support
  	#hence, no cookies etc which are required by sign_in function
  	describe "with valid info" do 
  		before do
			@params = {
				basic_info:{
					date_of_birth:"1985-12-13",
					height:183,
					weight:90
				}
			}
		end
			it "should create basic_info for current user " do 
				expect {post :create, @params}.to change(BasicInfo,:count).by(1)
			end
  	end

  	describe "with invalid info" do 
  		before do 
  			@params = {
				basic_info:{
					date_of_birth:"1985-12-13",
					height:183,
				}
			}
			it "should create basic_info for current user " do 
				expect {post :create, @params}.not_to change(BasicInfo,:count)
			end
  		end
  	end
  end

  describe "update basic info with patch" do 
  	let(:user) { FactoryGirl.create(:user) }

  	before do 
  		sign_in user, no_capybara: true
  		@params = {
				basic_info:{
					date_of_birth:"1985-12-13",
					height:182,
					weight:90
				}
			}
			#patch :update, id:user,@params
			patch :update, id:user.basic_info.id, basic_info:{
				date_of_birth:"1985-12-13",
				height:182,
				weight:90
			}
  	end

  	it "should update basic info" do
  		user.reload
  		user.basic_info.height.should == 182
  	end
  end
end