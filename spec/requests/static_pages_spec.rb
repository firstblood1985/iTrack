require 'spec_helper'

describe "StaticPages" do
subject { page }
  describe "Home page" do
	before {visit root_path}
	it do
	should have_content('iTrack') 
	should have_title(full_title(''))
    end


  describe "for user with basic info" do 
    let(:user) { FactoryGirl.create(:user)}

    before do 
      sign_in user 
      visit root_url
    end

    describe "it should not punch" do 
      it do 
        should have_button ("Punch") 
        should have_selector("input[type=number][placeholder='Punch Your Ks']")
      end
      describe 'click punch button to punch' do 
        let (:number) {5}
        before { fill_in 'punch_input', with:number}

        it do 
          expect {click_button('Punch')}.to change(Punch,:count).by(1)    
          should have_button("Unpunch")
        end
      end  
    end

    describe "it should show unpunch after punch" do 
      before do  
        user.punch(1.5)
        visit root_url
       end 
      
      it do 
        should have_button("Unpunch")
      end 
    end

    describe "it should show basic info" do 
      it do
      should have_content ("Date of Birth")
      should have_content("Height")
      should have_content("Weight")
      should have_content("BMI")
      should have_button("Update")
      end
    end 
  end  

  describe "for user without basic info" do 
    let(:user) {FactoryGirl.create(:example_user_without_basic_info)}

    before do 
      sign_in user
      visit root_path
    end

    describe "should allow user to create basic_info" do 
      it {should have_link('Create your basic health info',href:new_basic_info_path)}
    end

    describe "should render create basic_info form after click link" do 

      it "should render basic_info form" , js:true do 
        click_link 'Create your basic health info'  
        page.should have_content("Date of birth")
        page.should have_content("Height")
        page.should have_content("Weight")
      end
    end
  end
  describe "for signed in user" do 
    let(:user) {FactoryGirl.create(:user)}
    before do 
    FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
    FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
    sign_in user
    visit root_path
    end

    it "should render user's feed" do
      user.feed.each do |item|
        expect(page).to have_selector("li##{item.id}", text: item.content)
      end
    end

    describe "following/followers count" do
      let(:other_user) {FactoryGirl.create(:user)}

      before do
        other_user.follow!(user)
        visit root_path
      end

      it {should have_link('0 following'), href:following_user_path(user)}
      it {should have_link('1 followers'), href:followers_user_path(user)}
    end
  end

  end

  describe "Help Page" do
	before {visit help_path}

  	it "should have the content 'Help' "do
  	#visit '/static_pages/help'
  	expect(page).to have_content('Help')
    expect(page).to have_title('iTrack | Help')
  end
  end

  describe "About Page" do
	before {visit about_path}
  	it "should have the content 'About me'" do
  		expect(page).to have_content('About me')
	    expect(page).to have_title('iTrack | About me')
  	end
  end

  describe "Contact Page" do
	before {visit contact_path}
  	it "should have content 'Contact'" do 
  		expect(page).to have_content('Contact')
	    expect(page).to have_title('iTrack | Contact')
  	end
  end
end

