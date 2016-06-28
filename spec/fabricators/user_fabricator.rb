Fabricator(:user) do
  email { Faker::Internet.email }
  password 'pa$$w0rd'
end
