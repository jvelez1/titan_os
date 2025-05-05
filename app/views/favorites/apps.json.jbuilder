json.array! favorite_apps do |favorite_app|
  json.extract! favorite_app, :id, :position
  json.streaming_app do
    json.extract! favorite_app.streaming_app, :id, :name
  end
end
