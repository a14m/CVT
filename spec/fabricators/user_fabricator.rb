Fabricator(:user) do
  email { Faker::Internet.email }
  password 'pa$$w0rd'
  stripe_id { Faker::Lorem.word }
  expires_at { 3.days.from_now }
end
