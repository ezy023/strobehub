require 'spec_helper'

describe 'profile page' do
  before do
    @user = FactoryGirl.create(:user)
    @repo = FactoryGirl.build(:repository)
    @repo.creator = @user
    @repo.save
    visit login_path
    fill_in 'sessions[username]', :with => @user.username
    fill_in 'sessions[password]', :with => @user.password
    click_button 'Log In'
  end

  it "should display profile image" do
    page.should have_css("img[alt=Gravatar]")
  end

  it "should display user's name" do
    page.should have_content(@user.username)
  end

  it "should list the users created repos" do
    page.should have_content(@user.created_repositories.first.name)
  end

  it "should list the users sporked repos" do
    version = FactoryGirl.build(:version)
    version.user = @user
    repository = FactoryGirl.build(:repository)
    repository.creator_id = 3
    repository.save
    version.repository = repository
    version.save
    page.should have_content(version.repository.name)
  end

end
