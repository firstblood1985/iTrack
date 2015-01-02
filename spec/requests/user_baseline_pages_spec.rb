require 'spec_helper'
describe "User Baseline pages" do 
subject { page }
  describe "Home page" do
    let(:user) { FactoryGirl.create(:user)}
    let(:baseline)  {FactoryGirl.create(:baseline)}
    let(:another_baseline) {FactoryGirl.create(:another_baseline)}

    before do 
    baseline.save
    another_baseline.save
    sign_in user 
    visit root_path
    end
    describe "it should have selector for baseline" do
        it do 
          should have_content("select a baseline")
          should have_select("select_baseline",options:['','100m Row','500m Row'])
        end
    end
end
end