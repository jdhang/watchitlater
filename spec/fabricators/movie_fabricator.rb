Fabricator(:movie) do
  title { Faker::Lorem.characters(4) }
end
