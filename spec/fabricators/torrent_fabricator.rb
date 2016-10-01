Fabricator(:torrent) do
  user

  name { Faker::Lorem.word }
  transmission_id { rand(0..100) }
  size { rand(100..20000) }
  checksum { Faker::Crypto.sha1 }
  torrent { File.new("#{Rails.root}/spec/fixtures/files/test.torrent") }
end
