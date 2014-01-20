# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    sequence(:name) {|n| "mayth#{n}"}
    screen_name "秋弦めい"
    password "pwpwpwpw"
    twitter_id "@maytheplic"
  end
end
