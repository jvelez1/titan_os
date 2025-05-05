class UserChannelProgram < ApplicationRecord
  belongs_to :user
  belongs_to :channel_program

  validates :time_watched_in_seconds, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
