require 'spec_helper'
require 'pp'

describe UsersController do

	describe "get user punch history" do 
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "with valid info" do 
  		before do
  			10.times do 
  				FactoryGirl.create(:punch_history,user:user) 
  			end
		end
		#send async request to user controller to get punch_history
			it "should get user's punch history" do 
			xhr :get, :punch_history, {id: user.id, start:9, end:0, format:'json'}
      		expect(response).to be_success	
      		response.content_type.should eq 'application/json'
      		p_history= JSON.parse(response.body)
      		p_history.to_a.size.should == 10
			end
  	end
	end	
end