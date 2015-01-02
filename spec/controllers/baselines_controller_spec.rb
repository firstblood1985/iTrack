require 'spec_helper'
describe BaselinesController do
	let(:user_without_basic_info) { FactoryGirl.create(:user_without_basic_info) }
	  describe "create baseline with post" do
	  	before { sign_in_admin user_without_basic_info, no_capybara: true }

	  	describe "with valid info" do 
  		before do
			@params = {
				baseline:{
					name:"1000m Row",
					description: "Row 1000m as fast as you can",
					baseline_type: "rep"
				}
			}
		end
			it "should create new baseline " do 
				expect {post :create, @params}.to change(Baseline,:count).by(1)
			end

	  end
	end
end