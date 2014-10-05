require 'spec_helper'

describe User do
	#the most out layer 'before' will be excuted for each testcase, which happens inside 'it' block
	before { @user = User.new(name: 'Min Li',email:'limin.hust@foxmail.com',password:'foobar',password_confirmation:'foobar')}

	subject {@user}
	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should be_valid}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:remember_token)}
	it {should respond_to(:admin)}
	it {should respond_to(:authenticate)}

	it {should be_valid}
	it {should_not be_admin}

    describe "with admin attribute set to 'true'" do
    	before do
    		@user.save!
      		@user.toggle!(:admin)
    	end

    	it { should be_admin }
  	end

	describe "remember token" do
		before {@user.save}

		its (:remember_token) {should_not be_blank}
		# it {expect (@user.remember_token).not_to be_blank}
	end
	describe "return value of authenticate method" do
		before {@user.save}

		let(:found_user) {User.find_by(email:@user.email)}

		describe "with valid passsword" do		
			it {
				should eq found_user.authenticate(@user.password)
			}
		end

		describe "with invalid password" do
    		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    		it { should_not eq user_for_invalid_password }
    		specify { expect(user_for_invalid_password).to be_false }
  		end
	end
	describe "when name is not present" do 
		before{ @user.name = '   '}
		it {should_not be_valid}
	end

	describe "when email is not present" do
		before { @user.update_attribute :email, '  ' }
		it {should_not be_valid}
	end

	describe "when username is too long" do
		before { @user.name = "a"*100 }
		it {should_not be_valid}
	end

	describe "when username is too short" do 
		before {@user.name = "ab"}
		it {should_not be_valid}
	end

	describe "when email format is not invalid" do 
		it "should be invalid" do
		addresses = %w[user@foo,com usersat_foo.org example.user@foo@foo.com] 
		addresses.each do |invalid_address|
				@user.email = invalid_address	
				#it {should_not be_valid}
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
		addresses = %w[limin.hust@foxmail.com user@gmail.com min.li@ms.com]
		addresses.each do |valid_address|	
			@user.email = valid_address
			#it {should be_valid}
			expect(@user).to be_valid
		end
		end
	end

	describe "when email already taken" do
		before do
			user_with_same = @user.dup
			user_with_same.email = @user.email.upcase
			user_with_same.save
		end
		it{should_not be_valid} 
	end

	describe "when password is empty"  do
	before do 
		@user.password = '' 
		@user.password_confirmation= ''
	end
	it {should_not be_valid}
	end

	describe "when password doesnot match password_confirmation "	do
	before { @user.password = 'mismatch'}	
	it {should_not be_valid}
	end
end
