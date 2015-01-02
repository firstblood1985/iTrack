require 'spec_helper'

describe UserBaseline do

	let(:user)  {FactoryGirl.create(:user)}
	let(:baseline) {FactoryGirl.create(:baseline)}

	let(:user_baseline) {user.user_baselines.build(baseline_id:baseline.id,perf:"1'30''",perf_date:'2014-12-26')}

	subject{user_baseline}
	it{should be_valid}

	describe "user_baseline methods" do
		it {should respond_to (:user)}
		it { should respond_to(:baseline) }
		it { should respond_to(:perf)}
		it { should respond_to(:perf_date)}
    	its(:user) { should eq user }
    	its(:baseline) { should eq baseline }
	end

	describe "when user id is not present" do
    before { user_baseline.user_id = nil }
    it { should_not be_valid }
  	end

	describe "when baseline id is not present" do
    before { user_baseline.baseline_id = nil }
    it { should_not be_valid }
  	end
end
