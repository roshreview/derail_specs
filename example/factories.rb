FactoryBot.define do
  factory :test do
    sequence(:name) { |n| "Test #{n}" }
  end
end
