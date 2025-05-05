require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe 'GET /users/:user_id/favorites/channel_programs' do
    let(:user) { create(:user, email: 'user@example.com') }
    let(:channel_program1) { create(:channel_program, title: "Morning News") }
    let(:channel_program2) { create(:channel_program, title: "Evening Show") }
    let!(:user_channel_program1) do
      create(:user_channel_program, user: user, channel_program: channel_program1, time_watched_in_seconds: 2.days.ago.to_i)
    end
    let!(:user_channel_program2) do
      create(:user_channel_program, user: user, channel_program: channel_program2, time_watched_in_seconds: 1.day.ago.to_i)
    end

    context 'when the user exists' do
      it 'returns a list of favorite channel programs ordered by time_watched descending' do
        get favorites_channel_programs_path(user)

        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(2)

        expect(parsed_response[0]['id']).to eq(user_channel_program2.id)
        expect(parsed_response[1]['id']).to eq(user_channel_program1.id)

        expect(parsed_response[0].dig('content', 'title')).to eq("Evening Show")
        expect(parsed_response[1].dig('content', 'title')).to eq("Morning News")
      end

      it 'returns an empty list if the user has no favorite channel programs' do
        another_user = create(:user, email: 'another@example.com')
        get favorites_channel_programs_path(another_user)

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
end
