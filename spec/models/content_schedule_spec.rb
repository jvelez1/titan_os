require 'rails_helper'

RSpec.describe ContentSchedule, type: :model do
  it { should belong_to(:content) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
end
