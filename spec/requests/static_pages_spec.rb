require 'spec_helper'

describe "StaticPages" do
subject { page }
  describe "Home page" do
	before {visit root_path}
	it do
	should have_content('iTrack') 
	should have_title(full_title(''))
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

