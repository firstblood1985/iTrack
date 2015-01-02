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
	it {should respond_to(:microposts)}
	it {should respond_to(:feed)}
	it {should be_valid}
	it {should_not be_admin}
	it {should respond_to(:relationships)}
	it {should respond_to(:followed_users)}
	it { should respond_to(:following?) }
  	it { should respond_to(:follow!) }
  	it { should respond_to(:unfollow!)}
  	it { should respond_to(:followers)}
  	it {should respond_to(:basic_info)}
  	it {should respond_to(:punches)}
  	it {should respond_to(:punched_today?)}
  	it {should respond_to(:punch)}

  	describe "punch" do 
  		let(:user) {FactoryGirl.create(:user)}
  		it "today punch" do 
  			user.punch(4.5)
  			expect(user.today_punch).to eq(4.5)
  		end		
  		it "punched_today?" do 
  			user.punch(1.5)
  			expect(user.punched_today?).to eq(true) 
  		end

  		it "should only punch once" do 
  			user.punch(1.5)
  			expect {user.punch(1.5)}.to change(user.punches,:count).by(0)
  		end
  		it "create a punch" do 
  			expect do
            user.punch(1.5)
          end.to change(user.punches, :count).by(1)
  		end

  		it "unpunch" do 
  			user.punch(1.5)
  			expect {user.un_punch}.to change(user.punches,:count).by(-1)
  		end
  	end

  	describe "basic_info association" do 
  	let(:user) {FactoryGirl.create(:user)}		


  	it "should destroy associated basic info" do 
  		basic_info = user.basic_info
  		user.delete
  		expect(basic_info).not_to be_nil
  		expect(BasicInfo.where(id:basic_info.id)).to be_empty
  	end 	
  	end
  	describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "unfollow" do
    	before	{ @user.unfollow!(other_user) }
    	it {should_not be_following(other_user)}
    	its(:followed_users) {should_not include(other_user)}

    end

    describe "followers" do
    	subject {other_user}
    	its(:followers) {should include(@user)}
    end
  end

	describe "microposts association" do
		before {@user.save}
		let!(:older_micropost) do
			FactoryGirl.create(:micropost,user:@user,created_at:1.day.ago)
		end
		let!(:newer_micropost) do
			FactoryGirl.create(:micropost,user:@user,created_at:1.hour.ago)
		end


		it "should have the right microposts in the right order" do
      		expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    		end

  		it "should destroy associated microposts" do
  			microposts = @user.microposts.to_a
  			@user.destroy
  			expect(microposts).not_to be_empty
  			microposts.each do |micropost|
  				expect(Micropost.where(id:micropost.id)).to be_empty
  			end
  		end
  		describe "status" do 
  		let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      	end
      	let(:followed_user) { FactoryGirl.create(:user) }

      	before do
        	@user.follow!(followed_user)
        	3.times { followed_user.microposts.create!(content: "Lorem ipsum") }
      	end
      	its(:feed) { should include(newer_micropost) }
      	its(:feed) { should include(older_micropost) }
      	its(:feed) { should_not include(unfollowed_post) }
      	its(:feed) do
        followed_user.microposts.each do |micropost|
          should include(micropost)
        end
      	end
  		end
	end
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
