# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    sequence(:name) {|n| "mayth#{n}"}
    screen_name 'Mei Akizuru'
    password "pwpwpwpw"
    twitter_id "@maytheplic"
  end
end
