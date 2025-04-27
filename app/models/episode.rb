class Episode < Content
  belongs_to :season, -> { where(type: "Season") }, foreign_key: :parent_content_id, class_name: "Season"

  validates :number, numericality: { only_integer: true, greater_than: 0 }
end
