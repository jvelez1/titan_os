class UserApp < ApplicationRecord
  belongs_to :user
  belongs_to :streaming_app

  validates :position, numericality: { only_integer: true, greater_than: 0 }
end
