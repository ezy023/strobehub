require 'spec_helper'

describe RepoTag do

	context "validates presence" do
		it { should validate_presence_of (:repository) }
		it { should validate_presence_of (:tag) }
	end

	context "have associations" do
		it { should belong_to (:tag) }
		it { should belong_to (:repository) }
	end

	context "attributes are attr_accessible" do
		it { should allow_mass_assignment_of (:repository_id) }
		it { should allow_mass_assignment_of (:tag_id) }
	end

end

