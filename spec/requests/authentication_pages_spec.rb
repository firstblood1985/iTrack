require 'spec_helper'

describe "AuthenticationPages" do

	subject{page}

  describe "Authorization" do
    describe "for non-admin user" do
      let(:user) {FactoryGirl.create(:user)}
      let(:non_admin) {FactoryGirl.create(:user)}
      before do
         sign_in non_admin, no_capybara: true
      end

      describe "submit a DELETE request to the User#destroy action" do
        before {delete user_path(user)}
        specify{expect(response).to redirect_to(root_path)}
      end
    end

  	describe "for non-signed-in users" do
  		let(:user) {FactoryGirl.create(:user)}
      describe "in micropost controller" do  
        describe "submit create request" do 
        before {post microposts_path}
        it {expect(response).to redirect_to (signin_path)}
        end

        describe "submit delete request" do
          before {delete micropost_path(FactoryGirl.create(:micropost))}
          it{expect(response).to redirect_to (signin_path)}
        end
      end
      describe "visiting user index" do
          before {visit users_path}

          it {should have_title("Sign in")}
      end
      describe "visit a protected page" do 
        before do 
          visit edit_user_path(user)
          fill_in "Email", with:user.email
          fill_in "Password", with:user.password
          click_button "Sign in"
        end

        describe "after sign in " do 
          it "should render the protected page" do 
            expect(page).to have_title('Edit user')
          end
        end


      end

  		describe "visit the edit page" do
  			before {visit edit_user_path(user)}
  			it {should have_title('Sign in')}
  		end

  		describe "submit to the update action" do
  			before {patch user_path(user)}

  			it{expect(response).to redirect_to(signin_path)}
  		end
  	end
    	describe "as wrong user" do
  		let(:user){FactoryGirl.create(:user)}
  		let(:wrong_user) {FactoryGirl.create(:user,email:"wrong@example.com")}
  		before{sign_in user, no_capybara:true}

  		describe "submit GET request to user#edit" do
  			before {get edit_user_path(wrong_user)}

  			it{expect(response.body).not_to match(full_title('Edit user'))}
  			it{expect(response).to redirect_to(root_url)}
  		end


  	end
  end
  describe "visit signin_path" do
    	before {visit signin_path}

    	it {should have_content('Sign in')}
    	it {should have_title('Sign in')}
    	describe "sign in with invalid info" do
    		before {click_button "Sign in"}

    		it{should have_selector('div.alert.alert-error')}
    		it{should have_content('Sign in')}
    	end

    	describe "sign in with valid info" do
    		let(:user) {FactoryGirl.create(:user)}
    		before do
    			sign_in user
    		end

    		it {should have_title(user.name)}
        it {should have_link('Users'),href:users_path}
    		it {should have_link('Profile', href:user_path(user))}
    		it {should have_link('Setting', href:edit_user_path(user))}
    		it {should have_link('Sign out',href:signout_path)}
    		it {should_not have_link('Sign in',href:signin_path)}

    		describe "Then sign out" do
    			before {click_link "Sign out"}

    			it {should have_link('Sign in')}
    		end
    	end


    	describe "after visiting another page" do
    		before {click_link 'Home'}

    		it {should_not have_selector('div.alert.alert-error')}
    	end
    end
end
