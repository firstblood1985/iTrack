require 'spec_helper'

describe BasicInfo do
	let(:user) {FactoryGirl.create(:user)}

	before do
		@basic_info = user.basic_info 
	end
	subject {@basic_info}

	it {should respond_to(:date_of_birth)}
	it {should respond_to(:height)}
	it {should respond_to(:weight)}
	its(:user) {should eq user}

	describe "when user id is nil" do 
  		before { @basic_info.user_id = nil }
  		it {should_not be_valid}
  	end

  	describe "when  date of birth nil" do 
  		before {@basic_info.date_of_birth = nil}
  		it {should_not be_valid}
  	end

  	describe "when height is nil" do 
  		before {@basic_info.height = nil}
  		it {should_not be_valid}
  	end

  	describe "when weight is nil" do
  		before {@basic_info.weight = nil}
  		it {should_not be_valid}	
  	end

  	describe "when date of birth is invalid" do
  		describe "date of birth is tomorrow" do
  			before {@basic_info.date_of_birth = Date.tomorrow}
  			it {should_not be_valid}
  		end

  		describe "date of birth is 2015-10-25" do
			before {@basic_info.date_of_birth = Date.parse('2015-10-25')}
  			it {should_not be_valid}
  		end
  	end
end
