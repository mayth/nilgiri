# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :machine do
    sequence(:name) {|n| "Machine #{n}"}
    sequence(:slug) {|n| "machine-#{n}"}
    difficulties %w(BASIC MEDIUM HARD)
    playstyles %w(SP DP)
  end
end
