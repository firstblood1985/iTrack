require 'spec_helper'

describe "BasicInfoPages" do
	describe "in basic_infos_controller"
		subject {page}
		let (:user) {FactoryGirl.create(:user)}
		before {sign_in user}
		describe " valid info to create basic_info" do
			
		end
    end
