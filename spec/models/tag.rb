require 'spec_helper'

describe Tag do
	context "validates presence" do
		it { should validate_presence_of (:name) }
	end

	context "have associations" do
		it { should have_many (:repositories) }
	end

	context "attributes are attr_accessible" do
		it { should allow_mass_assignment_of (:name)}
	end

end
