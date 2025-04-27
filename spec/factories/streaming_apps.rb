FactoryBot.define do
  factory :streaming_app do
    sequence(:name) { |n| "StreamingApp #{n}" }
    description { "Description for streaming app" }
  end
end
