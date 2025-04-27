class StreamingApp < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
