FactoryBot.define do
  # factory :task do
  #   sequence(:name) { |n| "task#{n}" }
  #   sequence(:content) { |n| "content#{n}" }
  #   sequence(:limit) { |n| Time.local(2022, 9, 12, 9, 60-n*10, 0, 0) }
  #   sequence(:status) do |n| 
  #     status=["未着手","着手中","完了"]
  #     status[rand(2)] 
  #   end
  #   sequence(:priority) { |n| (n-1)%3 }
  # end

  # factory :task, class: Task do
  #   name { 'task' }
  #   content { 'content' }
  #   limit {Time.now}
  #   status {"着手中"}
  #   priority {2}
  # end
  
  factory :task1, class: Task do
    name { 'task1' }
    content { 'content1' }
    limit {Time.local(2022, 9, 12, 9, 50, 0, 0)}
    status {"着手中"}
    priority {0}
  end
  
  factory :task2, class: Task do
    name { 'task2' }
    content { 'content2' }
    limit {Time.local(2022, 9, 12, 9, 40, 0, 0)}
    status {"未着手"}
    priority {1}
  end
  
  factory :task3, class: Task do
    name { 'task3' }
    content { 'content3' }
    limit {Time.local(2022, 9, 12, 9, 30, 0, 0)}
    status {"未着手"}
    priority {2}
  end
 
end