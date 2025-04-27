require 'rails_helper'

RSpec.describe Season, type: :model do
  it_behaves_like 'a content model'

  it { should belong_to(:tv_show).class_name('TvShow').with_foreign_key(:parent_content_id) }
  it { should have_many(:episodes).class_name('Episode').with_foreign_key(:parent_content_id) }
  it { should validate_numericality_of(:number).only_integer.is_greater_than(0) }
end
