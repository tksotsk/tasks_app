FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
    sequence(:content) { |n| "content#{n}" }
    sequence(:limit) { |n| Time.local(2022, 9, 12, 9, 60-n*10, 0, 0) }
    sequence(:status) do |n| 
      status=["未着手","着手中","完了"]
      status[rand(2)] 
    end
  end

  factory :first_task, class: Task do
    name { 'task_chakusyuchuu' }
    content { 'content_chakusyuchuu' }
    limit {Time.now}
    status {"着手中"}
  end

  factory :second_task, class: Task do
    name { 'sample_chakusyuchuu' }
    content { 'content_chakusyuchuu' }
    limit {Time.now}
    status {"着手中"}
  end
end