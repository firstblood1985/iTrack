require 'spec_helper'

describe Performance do
 	before do
		 # This code is not idiomatically correct.
		@wod = Performance.new
	end

	it {should respond_to(:performance)}
end
