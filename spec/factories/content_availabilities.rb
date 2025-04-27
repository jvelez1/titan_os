FactoryBot.define do
  factory :content_availability do
    url { 'https://www.example.com' }

    association :content, factory: :movie
    association :country, factory: :country
    association :streaming_app, factory: :streaming_app
  end
end
