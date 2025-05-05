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

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
