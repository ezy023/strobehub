require 'spec_helper'

describe User do

  context "attributes are attr_accessible" do
    it { should allow_mass_assignment_of(:username)}
    it { should allow_mass_assignment_of(:email)}
    it { should allow_mass_assignment_of(:password)}
  end

  context "validates uniqueness" do
    it { should validate_uniqueness_of (:username) }
    it { should validate_uniqueness_of (:email) }
  end

  context "validates presence" do
    it { should validate_presence_of (:username) }
    it { should validate_presence_of (:email) }
    it { should validate_presence_of (:password) }
  end

  context "validates case insensitive" do
    it { should allow_value('username', 'UserName', 'USERNAME').for(:username)}
    it { should allow_value('example@example.com', 'EXAMPlE@EXAMPLE.COM', "Example@Example.com").for(:email)}
  end

 context "has associations" do
  it { should have_many (:versions)}
  it { should have_many (:repositories)}
 end 

 context "validates email format" do
    it { should allow_value('foo@bar.com', 'foo.bar@baz.com', 'foo@bz.com', 'foo_bar@baz.com', 'FOO@BAR.com', 'F99@bar.com').for(:email)}
    it { should_not allow_value('32@bar.com', 'myaddress', 'sweet@g.com', 'Bob <bob@gmail.com>', 'work?!@no.com', 'symbol_+%@gmail.ca').for(:email) }
  end

  context "validates password confirmation" do
    it { should respond_to(:password_confirmation)}
  end
end
