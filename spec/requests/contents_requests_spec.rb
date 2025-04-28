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
end
