# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    name "Mei Akizuru"
    sequence(:email) {|n| "mailaddr-#{n}@example.com"}
    twitter_id "@maytheplic"
    after(:build) do |p|
      p.password = 'pwpwpwpw'
    end
  end
end
