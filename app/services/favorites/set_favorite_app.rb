module Favorites
  class SetFavoriteApp
    def initialize(user, params)
      @user = user
      validate_params!(params)
      @app_id = params[:streaming_app_id]
      @position = params[:position]
    end

    def call
      UserApp.transaction do
        user_apps = @user.user_apps.order(:position).lock
        favorite_app = user_apps.find_or_initialize_by(streaming_app_id: @app_id)

        if favorite_app.persisted?
          return if favorite_app.position == @position
          user_apps.where("position > ?", favorite_app.position).update_all("position = position - 1")
        end

        user_apps.where("position >= ?", @position).update_all("position = position + 1")
        favorite_app.position = @position
        favorite_app.save!
      end
    end

    private

    def validate_params!(params)
      if params[:streaming_app_id].blank? || params[:position].blank?
        raise ArgumentError, "Missing required parameters"
      end
    end
  end
end
