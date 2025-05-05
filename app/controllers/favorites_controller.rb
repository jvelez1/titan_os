class FavoritesController < ApplicationController
  before_action :set_user

  def channel_programs
    favorite_channel_programs = @user.user_channel_programs
      .includes(:channel_program)
      .order(time_watched_in_seconds: :desc)
      .includes(:channel_program)

    render :channel_programs,
      formats: :json,
      locals: { favorite_channel_programs: favorite_channel_programs }
  end

  def apps
    favorite_apps = @user.user_apps
      .includes(:streaming_app)
      .order(position: :desc)

    render :apps,
      formats: :json,
      locals: { favorite_apps: favorite_apps }
  end

  def favorite_app
    Favorites::SetFavoriteApp.new(@user, favorite_app_params).call
    render json: { message: "Favorite app set successfully" }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def favorite_app_params
    params.permit(:streaming_app_id, :position)
  end
end
