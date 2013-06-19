require 'spec_helper'

describe Repository do

  context "validates presence" do
    it { should validate_presence_of (:name) }
    it { should validate_presence_of (:description) }
    it { should validate_presence_of (:creator_id) }
    it { should validate_presence_of (:master_version_id) }
  end

  context "have associations" do
    it { should have_many (:versions)}
    it { should have_many (:users)}
    it { should belong_to (:creator)}
    it { should belong_to (:master_version)}
  end 

  context "attributes are attr_accessible" do
    it { should allow_mass_assignment_of(:name)}
    it { should allow_mass_assignment_of(:description)}
    it { should allow_mass_assignment_of(:creator_id)}
    it { should allow_mass_assignment_of(:master_version_id)}
  end

end
