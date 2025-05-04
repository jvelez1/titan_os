json.partial! "contents/content", content: content

case content.type
when "TvShow"
  json.seasons content.seasons do |season|
    json.partial! "contents/content", content: season
    json.number season.number
    json.episodes season.episodes do |episode|
      json.number episode.number
      json.partial! "contents/content", content: episode
    end
  end
when "ChannelProgram"
  json.partial! "contents/content", content: content
  json.content_schedules content.content_schedules do |content_schedule|
    json.start_time content_schedule.start_time
    json.end_time content_schedule.end_time
  end
end
