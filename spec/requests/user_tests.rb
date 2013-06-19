require 'spec_helper'

describe 'profile page' do

  context 'with repositories to display' do
    before do
      @user = FactoryGirl.create(:user)   
      @repository = FactoryGirl.build(:repository)
      @repository.creator = @user
      @repository.save
      @version = FactoryGirl.build(:version)
      @version.user = @user
      @version.repository = @repository
      @version.save
      @repository.master_version_id = @version.id
      @repository.save
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

    it 'should have link to followers' do
      click_link "followers"
      current_path.should eq followers_user_path(@user)
    end

    it 'should have link to following' do
      click_link "following"
      current_path.should eq following_user_path(@user)
    end

    it "should provide link to the repos" do
      click_link @repository.name
      current_path.should eq repository_path(@repository)
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

    it 'should list out blank_feed if there is no activity' do
      page.should have_css('span.blank_feed')
    end
    
  end
end
