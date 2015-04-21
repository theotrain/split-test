Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password(5) }
  screen_name { Faker::Name.name }
end