# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :music do
    sequence(:name) {|n| "Music #{n}"}
    sequence(:artist) {|n| "Artist #{n}"}
    machine
    season
  end
end
