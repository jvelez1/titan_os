require 'rails_helper'

RSpec.describe "Contents", type: :request do
  describe 'GET #index' do
    let(:country_gb) { create(:country, code: 'GB') }
    let(:country_es) { create(:country, code: 'ES') }
    let!(:movie_gb) { create(:movie, title: "Rambo") }
    let!(:availability_gb) { create(:content_availability, content: movie_gb, country: country_gb) }
    let!(:tv_show_es) { create(:tv_show, title: "The last of us") }
    let!(:availability_es) { create(:content_availability, content: tv_show_es, country: country_es) }

    context 'when :country is provided' do
      it 'returns contents filtered by country' do
        get contents_path, params: { country: 'GB' }
        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(1)
      end

      it 'returns contents filtered by country and type' do
        get contents_path, params: { country: 'GB', type: 'Movie' }
        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(1)
      end

      it 'returns no contents if type does not match' do
        get contents_path, params: { country: 'GB', type: 'invalid' }
        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(0)
      end
    end

    context 'when :country is not provided' do
      it 'returns an error' do
        get contents_path
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response).to eq({ 'error' => "param is missing or the value is empty or invalid: country" })
      end
    end
  end

  describe 'GET #show' do
     let!(:movie) { create(:movie, title: "Rambo") }
     let!(:tv_show) { create(:tv_show, title: "The Last of Us") }
     let!(:season) { create(:season, parent_content: tv_show, title: "Season 1", number: 1) }
     let!(:episode) { create(:episode, parent_content: season, title: "Episode 1", number: 1) }
     let!(:channel_program) { create(:channel_program, title: "News at 9") }
     let!(:content_schedule) { create(:content_schedule, content: channel_program, start_time: "2023-01-01 09:00:00", end_time: "2023-01-01 10:00:00") }

     context 'when the content exists' do
       it 'returns the movie content' do
         get content_path(movie.id)
         expect(response).to have_http_status(:ok)
         expect(parsed_response['title']).to eq("Rambo")
         expect(parsed_response['type']).to eq("Movie")
       end

       it 'returns the tv show content with seasons and episodes' do
         get content_path(tv_show.id)
         expect(response).to have_http_status(:ok)
         expect(parsed_response['title']).to eq("The Last of Us")
         expect(parsed_response['type']).to eq("TvShow")
         expect(parsed_response['seasons'].size).to eq(1)
         expect(parsed_response['seasons'][0]['number']).to eq(1)
         expect(parsed_response['seasons'][0]['episodes'].size).to eq(1)
         expect(parsed_response['seasons'][0]['episodes'][0]['number']).to eq(1)
       end

       it 'returns the channel program content with schedules' do
         get content_path(channel_program.id)
         expect(response).to have_http_status(:ok)
         expect(parsed_response['title']).to eq("News at 9")
         expect(parsed_response['type']).to eq("ChannelProgram")
         expect(parsed_response['content_schedules'].size).to eq(1)
         expect(parsed_response['content_schedules'][0]['start_time']).to eq("2023-01-01T09:00:00.000Z")
         expect(parsed_response['content_schedules'][0]['end_time']).to eq("2023-01-01T10:00:00.000Z")
       end
     end

     context 'when the content does not exist' do
       it 'returns a 404 error' do
         get content_path(-1)
         expect(response).to have_http_status(:not_found)
         expect(parsed_response).to eq({ 'error' => "Record not found" })
       end
     end
   end
end
