require 'spec_helper'

describe Version do

	context "show version" do
		before :each do
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
		end

		it "indicates whether a version is the master version" do
			master_version = Version.find(@repository.master_version_id)
			visit repository_version_path(@repository, master_version)
			page.should have_content("Master Version")
		end

		it "displays all tracks associated with that version" do
		end

		it "saves state of tracks" do
		end

		describe "sporked versions" do
			before :each do
				user = User.create(:username => "goatsahoy", :email => "goats@ahoy.com", :password => "password")
				visit login_path
		    fill_in 'sessions[username]', :with => user.username
		    fill_in 'sessions[password]', :with => user.password
		    click_button 'Log In'
				visit repository_version_path(@repository, @version)
			end

			it "shows spork option if current user is not version owner" do
				page.should have_button("Spork this")
			end

			it "can spork a new version and navigate to that new version show page" do
				click_button 'Spork this'
				sporked_version = Version.last
				current_path.should eq repository_version_path(@repository, sporked_version)
			end

			it "shows link to version history" do
				click_button 'Spork this'
				page.should have_link("View version history")
			end

			it "redirects to version history after clicking link" do
				click_button 'Spork this'
				sporked_version = Version.last
				click_link("View version history")
				current_path.should eq version_history_path(@repository, sporked_version)
			end
		end

		describe "no logged in user" do
			before :each do
				visit repository_version_path(@repository, @version)
			end

		  it "shows spork option if user is not logged in" do
				page.should have_button("Spork this")
			end

		  it "redirects to login page if spork is clicked" do
		 	 click_button 'Spork this'
		 	 current_path.should eq login_path
		  end

		  it "flashes an error if spork is clicked" do
		  	click_button 'Spork this'
		  	expect {flash[:error]}.to_not be_nil
		  end

		  it "redirects to login page if save is clicked" do
		  	click_button "SAVE IT"
		  	current_path.should eq login_path
		  end

		  it "hides 'favorite' button if no user is signed in" do
		  	page.should_not have_button 'Favorite'
		  end

		end

	end

end