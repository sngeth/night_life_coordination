FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    admin false
  end

  factory :bar do
    name "A bar"
    description "fancy"
  end
end
