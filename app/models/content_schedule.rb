class ContentSchedule < ApplicationRecord
  belongs_to :content, class_name: "ChannelProgram", foreign_key: :content_id

  validates :start_time, presence: true
  validates :end_time, presence: true
end
