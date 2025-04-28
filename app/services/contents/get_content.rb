module Contents
  class GetContent
    def initialize(params)
      @params = params
    end

    def call
      content = Content.find_by!(id: params[:id])

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
    attr_reader :params
  end
end
