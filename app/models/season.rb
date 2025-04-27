class Season < Content
  belongs_to :tv_show, -> { where(type: "TvShow") }, foreign_key: :parent_content_id, class_name: "TvShow"
  has_many :episodes, -> { where(type: "Episode") }, foreign_key: :parent_content_id, class_name: "Episode"

  validates :number, numericality: { only_integer: true, greater_than: 0 }
end
