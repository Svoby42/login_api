User.destroy_all
Post.destroy_all

User.create!([{
                full_name: "Pepa Olsak",
                name: "olsak",
                email: "olsak@spsmb.cz",
                password: "razdvatri",
                password_confirmation: "razdvatri"
              }])

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@domain.cz"
  password = "razdvatri"
  User.create!(
    full_name: "#{name} #{name}",
    name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

users = User.order(:created_at)
10.times do
  users.each { |user| user.posts.create!([{
                                            title: Faker::Company.unique.bs,
                                            content: Faker::Lorem.sentence(word_count: 10),
                                            user_id: user.id
                                          }]) }
end