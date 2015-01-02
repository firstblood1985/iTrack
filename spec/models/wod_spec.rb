require 'spec_helper'

describe Wod do
 	before do
		 # This code is not idiomatically correct.
		@wod = Wod.new
	end

	it {should respond_to(:name)}
	it {should respond_to(:description)}

end
