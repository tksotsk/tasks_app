FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "email#{n}@aaa.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {false}
  end
  factory :user1, class: User do
    name { "user1" }
    email { "user1@xxx.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {false}
  end
  factory :user2, class: User do
    name { "user2" }
    email { "user2@xxx.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {false}
  end
  
  factory :admin_user, class: User do
    id {3}
    name { "admin" }
    email { "admin@xxx.com" }
    password { "qqqqqqqq" }
    password_confirmation { "qqqqqqqq" }
    admin {true}
  end
end
