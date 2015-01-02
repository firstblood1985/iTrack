require 'spec_helper'
describe UserBaselinesController do
	let(:user) { FactoryGirl.create(:user) }
	let(:baseline) {FactoryGirl.create(:baseline)}
	before { sign_in user, no_capybara: true }

	describe "with valid info" do 
  		before do
			@params = {
				user_baseline:{
					baseline_id: baseline.id,
					perf: "01:35",
					perf_additional: "",
					perf_date: "2014-12-22"
				}
			}
		end
			it "should create a user_baseline for current user " do 
				expect {post :create, @params}.to change(UserBaseline,:count).by(1)
			end
  	end
	
end