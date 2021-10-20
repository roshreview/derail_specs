FactoryBot.define do
  factory :test do
    sequence(:name) { |n| "Test #{n}" }

    trait(:trait1)
  end
end
