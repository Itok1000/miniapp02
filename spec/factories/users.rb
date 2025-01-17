FactoryBot.define do
  factory :user do
    user_name { "侍君一号" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "katanagari" }
    password_confirmation { "katanagari" }
  end
end
