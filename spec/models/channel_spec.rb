require 'rails_helper'

RSpec.describe Channel, type: :model do
  it_behaves_like 'a content model'

  it { should have_many(:channel_programs).class_name('ChannelProgram').with_foreign_key(:parent_content_id) }
end
