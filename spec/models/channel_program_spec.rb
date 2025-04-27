require 'rails_helper'

RSpec.describe ChannelProgram, type: :model do
  it_behaves_like 'a content model'

  it { should belong_to(:channel).class_name('Channel').with_foreign_key(:parent_content_id) }
end
