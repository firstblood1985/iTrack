require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do

    it "should have the content 'iTrack'" do
      visit '/static_pages/home'
      expect(page).to have_content('iTrack')
      expect(page).to have_title('iTrack | Home')
    end
  end

  describe "Help Page" do
  	it "should have the content 'Help' "do
  	visit '/static_pages/help'
  	expect(page).to have_content('Help')
    expect(page).to have_title('iTrack | Help')
  end
  end

  describe "About Page" do
  	it "should have the content 'About me'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('About me')
	    expect(page).to have_title('iTrack | About me')
  	end
  end
end

