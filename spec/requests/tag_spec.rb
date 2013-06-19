require 'spec_helper'

describe Tag do

	context 'show tags'

	before :each do
		@tag = FactoryGirl.create(:tag)
		@user = FactoryGirl.create(:user)
		@repo = FactoryGirl.build(:repository)
		@repo.creator = @user
		@repo.save
		@repo.tags << @tag
	end

	it "should display tag names on index" do
		visit tags_path
		page.should have_content(@tag.name)
	end

	it "should redirect to correct tag page from index" do
		visit tags_path
		click_link @tag.name
		current_path.should eq tag_path(@tag)
	end

	it "should show repositories associated with the tag on tags#show" do
		visit tag_path(@tag)
		page.should have_content(@tag.repositories.first.name)
	end

	describe "tag view on repository page" do
		before :each do
			@version = FactoryGirl.build(:version)
	    @version.user = @user
	    @version.repository = @repo
	    @version.save
	    @repo.master_version_id = @version.id
	    @repo.save
			visit repository_path(@repo)
		end

		it "should display tags on repository page" do
			page.should have_content(@tag.name)
		end

		it "should redirect to correct tag page from repository page" do
			click_link @tag.name
			current_path.should eq tag_path(@tag)	
		end

		it "should display tags on version page" do
			visit repository_version_path(@repo, @version)
			page.should have_content(@tag.name)
		end

		it "should redirect to correct tag page from version page" do
			visit repository_version_path(@repo, @version)
			click_link @tag.name
			current_path.should eq tag_path(@tag)	
		end
	end
end