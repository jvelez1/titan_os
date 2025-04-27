RSpec.shared_examples 'a content model' do
  it { should belong_to(:parent_content).class_name('Content').optional }
  it { should have_many(:children).class_name('Content').with_foreign_key(:parent_content_id) }

  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:year).only_integer.allow_nil }
  it { should validate_numericality_of(:duration_in_seconds).only_integer.allow_nil }
end
