class TvShow < Content
  has_many :seasons, -> { where(type: "Season") }, foreign_key: :parent_content_id, class_name: "Season"
end
