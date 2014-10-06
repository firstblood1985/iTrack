require 'spec_helper'

describe "MicropostPages" do
	subject {page}
	let (:user) {FactoryGirl.create(:user)}
	before {sign_in user}

	describe "micropost destroy" do
		before{ FactoryGirl.create(:micropost,user:user)}

		describe "as correct user" do
			before {visit root_path}
			it "should delete a micropost" do 
				expect {click_link 'delete'}.to change(Micropost,:count).by(-1)
			end
		end
	end
	describe "micropost create" do
		before {visit root_path}
		describe "with invalid info" do
			it "should not create micropost with blank content" do  
				expect {click_button "Post"}.not_to change(Micropost,:count)
			end
			describe "with error message" do
				before {click_button "Post"} 
				it {should have_content("error")}	
			end

			describe "with content too long" do
				before do 
					fill_in "micropost_content", with: "a"*141
					click_button "Post"
				end 

				it {should have_content("error")}
			end
		end

		describe "with valid info" do 
			before do 
				fill_in "micropost_content",with:"Lorem ipsum"
			end		
			it "micropost creation success" do 
				expect {click_button "Post"}.to change(Micropost,:count).by(1)
				should have_content("created")
			end
		end

	end
end
