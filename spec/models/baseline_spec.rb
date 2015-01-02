require 'spec_helper'

describe Baseline do
 	before do
		 # This code is not idiomatically correct.
		@baseline = Baseline.new
	end

	subject{ @baseline }
	it {should respond_to(:name)}
	it {should respond_to(:description)}
	it {should respond_to(:baseline_type)}	

	describe 'if type is rep or time' do 
		before {@baseline.baseline_type = "rep"}
		it{should be_valid}
	end

	describe "if type is not rep or time" do 
		before {@baseline.baseline_type = "number"}
		it{should_not be_valid}
	end

end