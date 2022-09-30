FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    name { Faker::Name.unique.first_name }   # ensuring we get unique values
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end