class Content < ApplicationRecord
  self.inheritance_column = :type

  belongs_to :parent_content, class_name: "Content", optional: true
  has_many :children, class_name: "Content", foreign_key: :parent_content_id
  has_many :content_availabilities

  validates :title, presence: true
  validates :year, numericality: { only_integer: true, allow_nil: true }
  validates :duration_in_seconds, numericality: { only_integer: true, allow_nil: true }
end
