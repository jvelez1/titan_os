class ContentSchedule < ApplicationRecord
  belongs_to :content

  validates :start_time, presence: true
  validates :end_time, presence: true
end
