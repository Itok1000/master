FactoryBot.define do
    factory :user do
      user_name { "シュクメルリ君" }
      sequence(:email) { |n| "user_#{n}@example.com" }
      password { "password" }
      password_confirmation { "password" }
    end
end