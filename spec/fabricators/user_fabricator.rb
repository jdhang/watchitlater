Fabricator(:user) {
  username { Faker::Name.first_name }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  password { "Testtest" }
  password_confirmation { "Testtest" }
}
