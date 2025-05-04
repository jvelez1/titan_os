module Contents
  class GetContent
    def initialize(id)
      @id = id
    end

    def call
      content = Content.find_by!(id: id)

      # Avoid N+1 when rendering.
      case content
      in TvShow
        seasons = content.seasons.includes(:episodes)
        content.seasons = seasons
        content
      in Channel
        channel_programs = content.channel_programs.includes(:content_schedules)
        content.channel_programs = channel_programs
        content
      else
        content
      end
    end

    private

    attr_reader :id
  end
end
