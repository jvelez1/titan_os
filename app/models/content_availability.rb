class ContentAvailability < ApplicationRecord
  belongs_to :content
  belongs_to :streaming_app
  belongs_to :country
end
