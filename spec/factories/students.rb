FactoryBot.define do
  factory :student do
    name { "Jane Smith" }
    association :teacher
  end
end