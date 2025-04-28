class ChannelProgram < Content
  belongs_to :channel, -> { where(type: "Channel") }, foreign_key: :parent_content_id, class_name: "Channel"

  has_many :content_schedules, foreign_key: :content_id, dependent: :destroy
end
