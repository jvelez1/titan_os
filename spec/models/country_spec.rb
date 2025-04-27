require 'rails_helper'

RSpec.describe Country, type: :model do
  subject { build(:country) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code) }
end
