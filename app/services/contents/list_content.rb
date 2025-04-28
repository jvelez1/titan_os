module Contents
  class ListContent
    def initialize(params, scope = Content)
      @params = params
      @scope = scope
    end

    def call
      country = Country.find_by!(code: params[:country])

      filter_by_country(country)
        .then { |scope| filter_by_content_type(scope, params[:content_type]) }
        .then { |scope | filter_by_query(scope, params[:query]) }
        .then { |scope|  scope.where(parent_content_id: nil).distinct }
    end

    private

    attr_reader :params, :scope

    def filter_by_country(country)
      scope.joins(:content_availabilities).where(content_availabilities: { country_id: country.id })
    end

    def filter_by_content_type(scope, content_type)
      return scope unless content_type

      scope.where(type: content_type)
    end

    def filter_by_query(scope, query)
      return scope unless query

      scope.where("title ILIKE :query OR CAST(year AS TEXT) ILIKE :query", query: "%#{query}%")
    end
  end
end
