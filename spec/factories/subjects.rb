FactoryBot.define do
  factory :subject do
    name { "Maths" }
    marks { 100 }
    association :student
  end
end