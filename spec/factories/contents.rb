FactoryBot.define do
  factory :content do
    title { "MyString" }
    year { 2023 }
    duration_in_seconds { 3600 }
    number { nil }
    parent_content { nil }
  end

  factory :movie, class: 'Movie' do
    title { "Interstellar" }
    type { 'Movie' }
  end

  factory :tv_show, class: 'TvShow' do
    title { "The last of us" }
    type { 'TvShow' }
  end

  factory :season, class: 'Season' do
    title { "S01" }
    type { 'Season' }
    number { 1 }
    association :parent_content, factory: :tv_show
  end

  factory :episode, class: 'Episode' do
    title { "Ep 1" }
    type { 'Episode' }
    number { 1 }
    association :parent_content, factory: :season
  end

  factory :channel, class: 'Channel' do
    title { "HBO" }
    type { 'Channel' }
  end

  factory :channel_program, class: 'ChannelProgram' do
    title { "Mundo animal" }
    type { 'ChannelProgram' }
    association :parent_content, factory: :channel
  end
end
