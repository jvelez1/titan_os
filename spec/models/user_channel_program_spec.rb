require 'rails_helper'

RSpec.describe UserChannelProgram, type: :model do
  subject { build(:user_channel_program, user: create(:user), channel_program: create(:channel_program)) }

  it { should belong_to(:user) }
  it { should belong_to(:channel_program) }

  it { should validate_numericality_of(:time_watched_in_seconds).only_integer.is_greater_than_or_equal_to(0) }
end
