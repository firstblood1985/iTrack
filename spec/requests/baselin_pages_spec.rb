require 'spec_helper'
describe "Baseline pages" do 
	subject {page}

	describe "sign in as normal user" do 
		let (:user) {FactoryGirl.create(:user) }

		before do
		sign_in user
		get new_baseline_path
		end
		it "should redirect to sign in page" do 
			expect{response}.to redirect_to (signin_path)
		end
	end

	describe "sign_in as admin" do 
		let (:admin) {FactoryGirl.create(:user)}

		before do 
		admin.admin = true
		admin.save!
		sign_in admin
		visit new_baseline_path
		end

		it {should have_content("Baseline")}

		describe " to create a new baseline" do 
		before do 
				fill_in "baseline[name]",with:"100m row"
				fill_in "baseline[description]", with:"row as fast as you can"
				select 'Rep', from:"baseline_baseline_type"
		end			

			it "should create a new baseline" do 
				expect {click_button 'Save'}.to change(Baseline,:count).by(1)	
				should have_content('100m row')
			end
		end
	end
end