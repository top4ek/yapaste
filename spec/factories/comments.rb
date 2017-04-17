FactoryGirl.define do
  factory :comment do
     message { FFaker::Lorem.paragraph }

     trait :empty_comment { message '' }

     factory :invalid_comment, traits: [:empty_comment]
  end
end
