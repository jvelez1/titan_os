class Channel < Content
  has_many :channel_programs, -> { where(type: "ChannelProgram") }, foreign_key: :parent_content_id, class_name: "ChannelProgram"
end
