require 'rails_helper'

RSpec.describe Contents::ListContent, type: :service do
  describe '#call' do
    let(:country_gb) { create(:country, code: 'GB') }
    let(:country_es) { create(:country, code: 'ES') }

    let!(:movie_gb) { create(:movie, title: 'Star Wars', year: 1980) }
    let!(:tv_show_gb) { create(:tv_show, title: 'Breaking Bad', year: 2008) }
    let!(:movie_es) { create(:movie, title: 'The Godfather', year: 1972) }

    let!(:availability_gb_movie) { create(:content_availability, content: movie_gb, country: country_gb) }
    let!(:availability_gb_tv_show) { create(:content_availability, content: tv_show_gb, country: country_gb) }
    let!(:availability_es_movie) { create(:content_availability, content: movie_es, country: country_es) }

    let(:params) { { country: 'GB' } }

    subject { described_class.new(params).call }

    context 'when filtering by country' do
      it 'returns contents available in the specified country' do
        result = subject
        expect(result).to contain_exactly(movie_gb, tv_show_gb)
      end

      it 'raises an error if the country does not exist' do
        params[:country] = 'FR'
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when filtering by content type' do
      it 'returns only movies when type is movie' do
        params[:type] = 'Movie'
        result = subject
        expect(result).to contain_exactly(movie_gb)
      end

      it 'returns only TV shows when type is tv_show' do
        params[:type] = 'TvShow'
        result = subject
        expect(result).to contain_exactly(tv_show_gb)
      end
    end

    context 'when filtering by query' do
      it 'returns contents matching the title query' do
        params[:query] = 'Star'
        result = subject
        expect(result).to contain_exactly(movie_gb)
      end

      it 'returns contents matching the year query' do
        params[:query] = '1980'
        result = subject
        expect(result).to contain_exactly(movie_gb)
      end

      it 'returns no contents if the query does not match anything' do
        params[:query] = 'Nonexistent'
        result = subject
        expect(result).to be_empty
      end
    end

    context 'when no parent_content_id is specified' do
      let!(:season) { create(:season, parent_content: tv_show_gb, title: "Season 1") }

      it 'excludes child contents' do
        result = subject
        expect(result).to contain_exactly(movie_gb, tv_show_gb)
      end
    end

    context 'when no filters are applied' do
      it 'returns all contents for the specified country' do
        result = subject
        expect(result).to contain_exactly(movie_gb, tv_show_gb)
      end
    end
  end
end
