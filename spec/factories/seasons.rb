# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season do
    sequence(:name) {|n| "Season #{n}"}
    sequence(:slug) {|n| "season-#{n}"}
    start { Time.now.yesterday }
    expiry { Time.now.tomorrow }
  end
end
