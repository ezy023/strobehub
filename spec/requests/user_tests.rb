require 'spec_helper'

describe 'profile page' do
  before do
    @user = FactoryGirl.create(:user)
    @repo = FactoryGirl.build(:repository)
    @repo.creator = @user
    @repo.save
    visit login_path
    fill_in 'static_pages[username]', :with => @user.username
    fill_in 'static_pages[password]', :with => @user.password
    click_button 'Log In'
  end

  it "should display profile image" do
    page.should have_css("img[alt=Gravatar]")
  end

  it "should display user's name" do
    page.should have_content(@user.username)
  end

  it "should have logged in user name at the top" do
    page.should have_content("Logged in as")
  end

  it "should list the users created repos" do
    page.should have_content(@user.created_repositories.first.name)
  end
end
