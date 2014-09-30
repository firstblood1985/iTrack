require 'spec_helper'

describe "UserPages" do
	subject{ page }
  describe "sign up page" do
  	before{visit signup_path}
  	it {should have_content('Sign up')}
  	it {should have_title(full_title('Sign up'))}
    end

   describe "profile page" do
   		let(:user) { FactoryGirl.create(:user)}
   		before {visit user_path(user)}

   		it {should have_content(user.name)}
   end

 describe "SignUp" do 
 		before {visit signup_path}

 		let(:submit) {"Create My Account"}

 		describe "invalid signup" do	
 		it "should not create a new user" do		
 			expect {click_button submit}.not_to change(User,:count)
 		end
 		end

    describe "valid signup" do

    before do
      fill_in "Name", with: "Min Li"
      fill_in "Email", with: "limin.hust@foxmail.com"
      fill_in "Password", with: "foobar"
      fill_in "Confirmation", with: "foobar"
    end
    it "should create a new user" do
      expect {click_button submit}.to change(User,:count).by(1)

    end
    describe "after saving the user" do
      before {click_button submit}
      let(:user) {User.find_by(email:"limin.hust@foxmail.com")}

      it {should have_link('Sign out',href:signout_path)}
      it {should have_title(user.name)}
      it {should have_selector('div.alert.alert-success',text:'Welcome')}
    end
    end
 end
  end
