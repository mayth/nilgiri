# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :music do
    name "Music Name"
    artist "Artist Name"
    machine
    season
  end
end
