require 'spec_helper'

describe Track do

  context "attributes are attr_accessible" do
    it { should allow_mass_assignment_of(:url)}
    it { should allow_mass_assignment_of(:delay)}
    it { should allow_mass_assignment_of(:offset)}
    it { should allow_mass_assignment_of(:duration)}
    it { should allow_mass_assignment_of(:volume)}
    it { should allow_mass_assignment_of(:track_length)}
  end

  context "validates presence" do
    it { should validate_presence_of (:url)}
    it { should validate_presence_of (:delay)}
    it { should validate_presence_of (:offset)}
    it { should validate_presence_of (:duration)}
    it { should validate_presence_of (:volume)}
    it { should validate_presence_of (:track_length)}
    it { should validate_presence_of (:version_id)}
  end

  context "has associations" do
    it { should belong_to (:version)}
  end 

end
