require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  setup do
    @user = create(:user, email: 'user@example.com')
    @another_user = create(:user, email: 'another@example.com')
  end

  describe 'GET /users/:user_id/favorites/channel_programs' do
    let(:channel_program1) { create(:channel_program, title: "Morning News") }
    let(:channel_program2) { create(:channel_program, title: "Evening Show") }
    let!(:user_channel_program1) do
      create(:user_channel_program, user: @user, channel_program: channel_program1, time_watched_in_seconds: 2.days.ago.to_i)
    end
    let!(:user_channel_program2) do
      create(:user_channel_program, user: @user, channel_program: channel_program2, time_watched_in_seconds: 1.day.ago.to_i)
    end

    context 'when the user exists' do
      it 'returns a list of favorite channel programs ordered by time_watched descending' do
        get favorites_channel_programs_path(@user)

        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(2)

        expect(parsed_response[0]['id']).to eq(user_channel_program2.id)
        expect(parsed_response[1]['id']).to eq(user_channel_program1.id)

        expect(parsed_response[0].dig('content', 'title')).to eq("Evening Show")
        expect(parsed_response[1].dig('content', 'title')).to eq("Morning News")
      end

      it 'returns an empty list if the user has no favorite channel programs' do
        get favorites_channel_programs_path(@another_user)

        expect(response).to have_http_status(:ok)
        expect(parsed_response).to eq([])
      end
    end

    context 'when the user does not exist' do
      it 'returns a 404 error' do
        get "/users/0/favorites/channel_programs", as: :json

        expect(response).to have_http_status(:not_found)
        expect(parsed_response).to eq({ 'error' => "Record not found" })
      end
    end
  end

  describe 'GET /users/:user_id/favorites/apps' do
    let(:streaming_app1) { create(:streaming_app, name: "Netflix") }
    let(:streaming_app2) { create(:streaming_app, name: "Hulu") }
    let!(:user_app1) { create(:user_app, user: @user, streaming_app: streaming_app1, position: 2) }
    let!(:user_app2) { create(:user_app, user: @user, streaming_app: streaming_app2, position: 1) }

    context 'when the user exists' do
      it 'returns a list of favorite apps ordered by position descending' do
        get favorites_apps_path(@user)

        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(2)

        expect(parsed_response[0]['id']).to eq(user_app2.id)
        expect(parsed_response[1]['id']).to eq(user_app1.id)

        expect(parsed_response[0]['streaming_app']['name']).to eq("Hulu")
        expect(parsed_response[1]['streaming_app']['name']).to eq("Netflix")
      end

      it 'returns an empty list if the user has no favorite apps' do
        get favorites_apps_path(@another_user)

        expect(response).to have_http_status(:ok)
        expect(parsed_response).to eq([])
      end
    end

    context 'when the user does not exist' do
      it 'returns a 404 error' do
        get "/users/0/favorites/apps", as: :json

        expect(response).to have_http_status(:not_found)
        expect(parsed_response).to eq({ 'error' => "Record not found" })
      end
    end
  end

  describe 'POST /users/:user_id/favorites/favorite_app' do
    let(:streaming_app) { create(:streaming_app, name: "Netflix") }
    let(:dazn) { create(:streaming_app, name: "DAZN") }
    let!(:user_app) { create(:user_app, user: @user, streaming_app: dazn, position: 1) }

    context 'when the user exists' do
      it 'sets the favorite app and returns a success message' do
        post favorite_app_path(@user), params: { streaming_app_id: streaming_app.id, position: 1 }, as: :json

        expect(response).to have_http_status(:ok)
        expect(parsed_response).to eq({ 'message' => "Favorite app set successfully" })

        user_app = @user.user_apps.find_by(streaming_app_id: streaming_app.id)
        expect(user_app).not_to be_nil
        expect(user_app.position).to eq(1)
      end

      it 'updates the position of other apps' do
        post favorite_app_path(@user), params: { streaming_app_id: streaming_app.id, position: 1 }, as: :json

        expect(response).to have_http_status(:ok)
        expect(parsed_response).to eq({ 'message' => "Favorite app set successfully" })

        user_app = @user.user_apps.find_by(streaming_app_id: streaming_app.id)
        expect(user_app).not_to be_nil
        expect(user_app.position).to eq(1)

        other_app = @user.user_apps.find_by(streaming_app_id: dazn.id)
        expect(other_app).not_to be_nil
        expect(other_app.position).to eq(2)
      end
    end

    context 'when the user does not exist' do
      it 'returns a 404 error' do
        post "/users/0/favorite_app", params: { streaming_app_id: streaming_app.id, position: 1 }, as: :json

        expect(response).to have_http_status(:not_found)
        expect(parsed_response).to eq({ 'error' => "Record not found" })
      end
    end

    context 'when invalid parameters are provided' do
      it 'returns a 422 error for invalid position' do
        post favorite_app_path(@user), params: { streaming_app_id: streaming_app.id, position: 0 }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include("Position must be greater than 0")
      end

      it 'returns a 400 error for missing parameters' do
        post favorite_app_path(@user), params: {}, as: :json

        expect(response).to have_http_status(:bad_request)
        expect(parsed_response).to eq({ 'error' => "Missing required parameters" })
      end
    end
  end
end
