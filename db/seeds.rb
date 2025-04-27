# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

# Embedded JSON data
data = {
  "movies": [
    {
      "original_title": "Star Wars: Episode V - The Empire Strikes Back",
      "year": 1980,
      "duration_in_seconds": 7440,
      "type": "movie",
      "availabilities": [
        {
          "app": "netflix",
          "market": "gb"
        },
        {
          "app": "prime_video",
          "market": "es"
        }
      ]
    },
    {
      "original_title": "The Godfather",
      "year": 1972,
      "duration_in_seconds": 10500,
      "type": "movie",
      "availabilities": [
        {
          "app": "netflix",
          "market": "es"
        },
        {
          "app": "prime_video",
          "market": "gb"
        }
      ]
    },
    {
      "original_title": "Pulp Fiction",
      "year": 1994,
      "duration_in_seconds": 9900,
      "type": "movie",
      "availabilities": [
        {
          "app": "netflix",
          "market": "gb"
        },
        {
          "app": "prime_video",
          "market": "es"
        }
      ]
    },
    {
      "original_title": "Interstellar",
      "year": 2014,
      "duration_in_seconds": 10140,
      "type": "movie",
      "availabilities": [
        {
          "app": "netflix",
          "market": "gb"
        },
        {
          "app": "prime_video",
          "market": "gb"
        }
      ]
    }
  ],
  "tv_shows": [
    {
      "original_title": "Kimetsu No Yaiba: Demon Slayer",
      "year": 2019,
      "duration_in_seconds": nil,
      "type": "tv_show",
      "seasons": [
        {
          "original_title": "Tanjiro Kamado, Unwavering Resolve Arc",
          "number": 1,
          "year": 2019,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            },
            {
              "app": "prime_video",
              "market": "gb"
            }
          ]
        },
        {
          "original_title": "Demon Slayer: Kimetsu no Yaiba - Mugen Train Arc/Entertainment District Arc",
          "number": 2,
          "year": 2022,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            },
            {
              "app": "prime_video",
              "market": "gb"
            }
          ]
        },
        {
          "original_title": "Demon Slayer: Kimetsu no Yaiba - Swordsmith Village Arc",
          "number": 3,
          "year": 2023,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            },
            {
              "app": "prime_video",
              "market": "gb"
            }
          ]
        }
      ],
      "episodes": [
        {
          "original_title": "Cruelty",
          "number": 1,
          "season_number": 1,
          "year": 2019,
          "duration_in_seconds": 3600
        },
        {
          "original_title": "Flame Hashira Kyojuro Rengoku",
          "number": 1,
          "season_number": 2,
          "year": 2022,
          "duration_in_seconds": 3600
        },
        {
          "original_title": "Someone's Dream",
          "number": 1,
          "season_number": 3,
          "year": 2023,
          "duration_in_seconds": 3600
        }
      ],
      "availabilities": [
        {
          "app": "netflix",
          "market": "gb"
        },
        {
          "app": "prime_video",
          "market": "gb"
        }
      ]
    },
    {
      "original_title": "Stranger Things",
      "year": 2016,
      "duration_in_seconds": nil,
      "type": "tv_show",
      "seasons": [
        {
          "original_title": "Season 1",
          "number": 1,
          "year": 2016,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            }
          ]
        },
        {
          "original_title": "Season 2",
          "number": 2,
          "year": 2017,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            }
          ]
        },
        {
          "original_title": "Season 3",
          "number": 3,
          "year": 2019,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            }
          ]
        },
        {
          "original_title": "Season 4",
          "number": 4,
          "year": 2022,
          "duration_in_seconds": nil,
          "availabilities": [
            {
              "app": "netflix",
              "market": "gb"
            },
            {
              "app": "prime_video",
              "market": "gb"
            }
          ]
        }
      ],
      "episodes": [
        {
          "original_title": "Chapter One: The Vanishing of Will Byers",
          "number": 1,
          "season_number": 1,
          "year": 2016,
          "duration_in_seconds": 3600
        },
        {
          "original_title": "Chapter One: MADMAX",
          "number": 1,
          "season_number": 2,
          "year": 2017,
          "duration_in_seconds": 3600
        },
        {
          "original_title": "Chapter One: Suzie, Do You Copy?",
          "number": 1,
          "season_number": 3,
          "year": 2019,
          "duration_in_seconds": 3600
        },
        {
          "original_title": "Chapter One: The Hellfire Club",
          "number": 1,
          "season_number": 4,
          "year": 2022,
          "duration_in_seconds": 3600
        }
      ],
      "availabilities": [
        {
          "app": "netflix",
          "market": "gb"
        },
        {
          "app": "prime_video",
          "market": "gb"
        }
      ]
    }
  ],
  "channels": [
    {
      "original_title": "Nickelodeon",
      "year": nil,
      "duration_in_seconds": nil,
      "type": "channel",
      "availabilities": [
        {
          "app": "Amagi",
          "market": "gb",
          "stream_info": {
            "url": "https://www.example.com"
          }
        },
        {
          "app": "Amagi",
          "market": "es",
          "stream_info": {
            "url": "https://www.example.com/es"
          }
        },
        {
          "app": "Wurl",
          "market": "gb",
          "stream_info": {
            "url": "https://www.example.com"
          }
        }
      ],
      "channel_programs": [
        {
          "original_title": "SpongeBob",
          "year": nil,
          "duration_in_seconds": nil,
          "type": "channel_program",
          "schedule": [
            {
              "start_time": "2024-03-11 08:00:00",
              "end_time": "2024-03-11 09:00:00"
            },
            {
              "start_time": "2024-03-11 09:00:00",
              "end_time": "2024-03-11 10:00:00"
            }
          ],
          "availabilities": [
            {
              "app": "Amagi",
              "market": "gb"
            },
            {
              "app": "Wurl",
              "market": "gb"
            }
          ]
        },
        {
          "original_title": "Hey Arnold!",
          "year": nil,
          "duration_in_seconds": nil,
          "type": "channel_program",
          "schedule": [
            {
              "start_time": "2024-03-11 10:00:00",
              "end_time": "2024-03-11 11:00:00"
            },
            {
              "start_time": "2024-03-11 15:00:00",
              "end_time": "2024-03-11 16:00:00"
            }
          ],
          "availabilities": [
            {
              "app": "Amagi",
              "market": "es"
            }
          ]
        }
      ]
    },
    {
      "original_title": "Euronews",
      "year": nil,
      "duration_in_seconds": nil,
      "type": "channel",
      "availabilities": [
        {
          "app": "Amagi",
          "market": "gb",
          "stream_info": {
            "url": "https://www.example.com"
          }
        },
        {
          "app": "Wurl",
          "market": "gb",
          "stream_info": {
            "url": "https://www.example.com"
          }
        }
      ],
      "channel_programs": [
        {
          "original_title": "News 24hr",
          "year": nil,
          "duration_in_seconds": nil,
          "type": "channel_program",
          "schedule": [
            {
              "start_time": "2024-03-11 06:00:00",
              "end_time": "2024-03-12 05:59:59"
            }
          ],
          "availabilities": [
            {
              "app": "Amagi",
              "market": "gb"
            },
            {
              "app": "Wurl",
              "market": "gb"
            }
          ]
        }
      ]
    }
  ]
}

# Helper methods to find or create related records
def find_or_create_streaming_app(name)
  StreamingApp.find_or_create_by!(name: name)
end

def find_or_create_country(market)
  Country.find_or_create_by!(name: market.upcase, code: market)
end

# Insert Movies
data[:movies].each do |movie_data|
  movie = Movie.create!(
    title: movie_data[:original_title],
    year: movie_data[:year],
    duration_in_seconds: movie_data[:duration_in_seconds]
  )

  movie_data[:availabilities].each do |availability|
    app = find_or_create_streaming_app(availability[:app])
    country = find_or_create_country(availability[:market])

    ContentAvailability.create!(
      content: movie,
      streaming_app: app,
      country: country
    )
  end
end

# Insert TV Shows
data[:tv_shows].each do |tv_show_data|
  tv_show = TvShow.create!(
    title: tv_show_data[:original_title],
    year: tv_show_data[:year],
    duration_in_seconds: tv_show_data[:duration_in_seconds]
  )

  # Add availabilities for the TV show
  tv_show_data[:availabilities].each do |availability|
    app = find_or_create_streaming_app(availability[:app])
    country = find_or_create_country(availability[:market])

    ContentAvailability.create!(
      content: tv_show,
      streaming_app: app,
      country: country
    )
  end

  # Insert Seasons
  tv_show_data[:seasons].each do |season_data|
    season = Season.create!(
      title: season_data[:original_title],
      year: season_data[:year],
      number: season_data[:number],
      parent_content: tv_show
    )

    season_data[:availabilities].each do |availability|
      app = find_or_create_streaming_app(availability[:app])
      country = find_or_create_country(availability[:market])

      ContentAvailability.create!(
        content: season,
        streaming_app: app,
        country: country
      )
    end
  end

  # Insert Episodes
  tv_show_data[:episodes].each do |episode_data|
    season = Season.find_by(parent_content: tv_show, number: episode_data[:season_number])

    Episode.create!(
      title: episode_data[:original_title],
      year: episode_data[:year],
      duration_in_seconds: episode_data[:duration_in_seconds],
      number: episode_data[:number],
      parent_content: season
    )
  end
end

# Insert Channels
data[:channels].each do |channel_data|
  channel = Channel.create!(
    title: channel_data[:original_title]
  )

  # Add availabilities for the channel
  channel_data[:availabilities].each do |availability|
    app = find_or_create_streaming_app(availability[:app])
    country = find_or_create_country(availability[:market])

    ContentAvailability.create!(
      content: channel,
      streaming_app: app,
      country: country,
      url: availability.dig(:stream_info, :url)
    )
  end

  # Insert Channel Programs
  channel_data[:channel_programs].each do |program_data|
    program = ChannelProgram.create!(
      title: program_data[:original_title],
      parent_content: channel
    )

    # Add schedules for the program
    program_data[:schedule].each do |schedule|
      ContentSchedule.create!(
        content: program,
        start_time: schedule[:start_time],
        end_time: schedule[:end_time]
      )
    end

    # Add availabilities for the program
    program_data[:availabilities].each do |availability|
      app = find_or_create_streaming_app(availability[:app])
      country = find_or_create_country(availability[:market])

      ContentAvailability.create!(
        content: program,
        streaming_app: app,
        country: country
      )
    end
  end
end
