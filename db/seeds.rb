require 'faker'

5.times do
	User.create(:username => Faker::Internet.user_name, :email => Faker::Internet.email, :password => "hello")
end

Repository.create(:name => "Space Jam Crunk Rum", :description => "These beats will make you strobe your face off", :creator_id => 1)
Repository.create(:name => "Face Slam Rage Crush", :description => "rage rage rage rage", :creator_id => 2)

4.times do
	Version.create(:user_id => User.all.sample.id, :repository_id => Repository.all.sample.id)
end


