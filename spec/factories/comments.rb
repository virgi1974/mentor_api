FactoryGirl.define do
  factory :comment do
    body "MyText"
    user nil
    conversation nil
  end
end
