require 'factory_girl'

FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password'
    username 'UserName'
  end

  factory :audiosource do
    file 'file'
  end

  factory :repository do
    name 'name'
    description 'description'
  end

   factory :track do
    url 'url'
    delay 1.0
    offset 0.1
    duration 1.0
    volume 0.1
    track_length 1.0
  end

  factory :version do
  end

end
