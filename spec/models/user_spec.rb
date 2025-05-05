require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { create(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }

    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should have_many(:user_channel_programs).dependent(:destroy) }
    it { should have_many(:channel_programs).through(:user_channel_programs) }
    it { should have_many(:user_apps).dependent(:destroy) }
    it { should have_many(:streaming_apps).through(:user_apps) }
  end
end
