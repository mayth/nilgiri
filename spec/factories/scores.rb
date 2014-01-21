# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    playstyle "SP"
    difficulty "HARD"
    score 1234
    player
    music
    season
  end
end
