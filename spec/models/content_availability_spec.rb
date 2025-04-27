require 'rails_helper'

RSpec.describe ContentAvailability, type: :model do
  it { should belong_to(:country) }
  it { should belong_to(:streaming_app) }
  it { should belong_to(:content) }
end
