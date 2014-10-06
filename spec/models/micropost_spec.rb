require 'spec_helper'

describe Micropost do
	let(:user) {FactoryGirl.create(:user)}

	before do
		 # This code is not idiomatically correct.
		@micropost = user.microposts.build(content: "Lorem ipsum")
	end

	subject { @micropost }
	it { should respond_to(:content) }
  	it { should respond_to(:user_id) }
  	it { should respond_to(:user) }
  	its(:user) {should eq user}
  	it {should be_valid}
  	describe "when user id is nil" do 
  		before { @micropost.user_id = nil }
  		it {should_not be_valid}
  	end

  	describe "when content is nil" do 
  		before {@micropost.content = nil}
  		it {should_not be_valid}
  	end

  	describe "when content is too long" do 
  		before {@micropost.content = "a" *141}
  		it {should_not be_valid}
  	end
end
