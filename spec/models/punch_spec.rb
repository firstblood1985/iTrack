require 'spec_helper'

describe Punch do
	let(:user) {FactoryGirl.create(:user)}

	before do
		 # This code is not idiomatically correct.
		@punch = user.punches.build(punch_date: "2014-10-20",number:5.0)
	end

	subject { @punch }

	it {should respond_to(:punch_date)}
	it {should respond_to(:number)}
end