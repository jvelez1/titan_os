FactoryBot.define do
  factory :user_app do
    user { build(:user) }
    streaming_app { build(:streaming_app) }
    position { 1 }
  end
end
