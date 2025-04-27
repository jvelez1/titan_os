require 'rails_helper'

RSpec.describe TvShow, type: :model do
  it_behaves_like 'a content model'

  it { should have_many(:seasons).class_name('Season').with_foreign_key(:parent_content_id) }
end
