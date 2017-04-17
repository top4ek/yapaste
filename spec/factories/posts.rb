FactoryGirl.define do
  factory :post do
     title { FFaker::Lorem.sentence }
     name  { FFaker::Lorem.sentence }
     snippet { FFaker::Lorem.paragraph }

     trait :wrong_title { title '' }
     trait :wrong_name { name '' }
     trait :wrong_snippet { snippet '' }

     factory :invalid_post, traits: %i[wrong_snippet wrong_name wrong_title]
  end
end
