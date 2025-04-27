require 'rails_helper'

RSpec.describe StreamingApp, type: :model do
  subject { build(:streaming_app) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
