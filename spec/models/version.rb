require 'spec_helper'

describe Version do

  context "validates presence" do
    it { should validate_presence_of (:user_id) }
    it { should validate_presence_of (:repository_id) }
  end

  context "has associations" do
    it { should have_many (:tracks)}
    it { should belong_to (:user)}
    it { should belong_to (:repository)}
    it { should belong_to (:parent_version)}
  end 

  context "attributes are attr_accessible" do
    it { should allow_mass_assignment_of(:user_id)}
    it { should allow_mass_assignment_of(:repository_id)}
    it { should allow_mass_assignment_of(:parent_version_id)} 
  end
  
end
