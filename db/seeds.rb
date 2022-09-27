# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "admin",email: "admin@xxxxx.com", password: "qqqqqqqq", password_confirmation: "qqqqqqqq", admin: true)

10.times do |i|
  User.create(name: "user#{i+1}",email: "user#{i+1}@xxxxx.com", password: "qqqqqqqq", password_confirmation: "qqqqqqqq", admin: false)
end

10.times do |i|
  Task.create(name: "task#{i+1}",content: "content#{i+1}", limit: Time.local(2022, 9, 12, 9, 50, 0, 0), status: "着手中", priority: 0)
end


10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end



