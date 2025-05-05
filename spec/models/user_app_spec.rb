require 'rails_helper'

RSpec.describe UserApp, type: :model do
  subject { build(:user_app, user: create(:user), streaming_app: create(:streaming_app)) }

  it { should belong_to(:user) }
  it { should belong_to(:streaming_app) }

  it { should validate_numericality_of(:position).only_integer.is_greater_than(0) }
end
