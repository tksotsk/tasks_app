FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
    sequence(:content) { |n| "content#{n}" }
  end
end