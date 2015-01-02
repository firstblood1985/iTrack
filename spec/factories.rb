FactoryGirl.define do 
factory :user do
	sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    basic_info BasicInfo.new(date_of_birth:"1985-12-22",height:183,weight:92)
    	factory :admin do
    		admin true
    	end

  end

factory :punch_history,class:Punch do 
    sequence(:punch_date) do |n|
        now = Date.today
        now - 2*n
    end
    sequence(:number) do |n|
        Random.new.rand(1..n%43)
    end
    user
end

factory :baseline do 
    name "500m Row"
    description "500m Row for time"
    baseline_type "time"
end
factory :another_baseline, class:Baseline do 
    name "100m Row"
    description "100m Row for time"
    baseline_type "time"
end
factory :wod do
    name "Ben's birthday WOD"
    description ""
end
factory :punch do 
    punch_date Date.current
    number 5.0
    user
end
factory :micropost do 
	content "Lorem ipsum"
	user
end
factory :example_user_without_basic_info, class:User do 
    name "Example User"
    email "example@railstutorial.org"
    password "foobar"
    password_confirmation "foobar"
end
factory :user_without_basic_info, class:User do 
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
end

factory :basic_info do 
    date_of_birth '1985-12-22'
    height 183
    weight 92
    user
end
end