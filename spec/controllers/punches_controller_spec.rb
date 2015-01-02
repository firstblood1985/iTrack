require 'spec_helper'

describe PunchesController do
let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "with valid info" do 
  		before do
			@params = {
				punch:{
					punch_date:"2014-10-23",
					number:10
				}
			}
		end
			it "should create a punch for current user, but only one punch for same day " do 
				expect {post :create, @params}.to change(Punch,:count).by(1)
				expect {post :create, @params}.to change(Punch,:count).by(0)
			end
  	end
end