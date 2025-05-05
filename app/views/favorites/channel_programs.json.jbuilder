json.array! favorite_channel_programs do |favorite_channel_program|
  json.extract! favorite_channel_program, :id, :time_watched_in_seconds

  json.content do
    json.partial! "contents/content", content: favorite_channel_program.channel_program
  end
end
