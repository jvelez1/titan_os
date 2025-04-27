require 'rails_helper'

RSpec.describe Episode, type: :model do
  it_behaves_like 'a content model'

  it { should belong_to(:season).class_name('Season').with_foreign_key(:parent_content_id) }
  it { should validate_numericality_of(:number).only_integer.is_greater_than(0) }
end
