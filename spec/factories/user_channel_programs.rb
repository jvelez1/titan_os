FactoryBot.define do
  factory :user_channel_program do
    user { build(:user) }
    channel_program { build(:channel_program) }
    time_watched_in_seconds { 1 }
  end
end
