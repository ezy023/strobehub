require 'spec_helper'

describe AudioSource do

  context "attributes are attr_accessible" do
    it { should allow_mass_assignment_of(:type)}
    it { should allow_mass_assignment_of(:filename)}
    it { should allow_mass_assignment_of(:title)}
    it { should allow_mass_assignment_of(:data)}
  end

  context "validates presence" do
    it { should validate_presence_of (:type) }
    it { should validate_presence_of (:filename) }
    it { should validate_presence_of (:title) }
    it { should validate_presence_of (:data) }
  end
  
end
