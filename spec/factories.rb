FactoryBot.define do
  factory(:user) do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
  factory(:link) do
    url { Faker::Internet.url }
    url_generated { Faker::Internet.password(min_length: 8) }
  end
end