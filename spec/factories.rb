FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyString" }
    user_id { 1 }
    topic_id { 1 }
  end

  factory :article do
    title { "MyString" }
    content { "MyString" }
    user_id { 1 }
    topic_id { 1 }
  end

  factory :user do
    full_name { Faker::Name.unique.name }
    name { Faker::Name.unique.first_name }   # ensuring we get unique values
    email { "#{Faker::Name.unique.first_name}@#{Faker::Internet.domain_name}" }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end