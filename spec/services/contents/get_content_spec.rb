require 'rails_helper'

RSpec.describe Contents::GetContent, type: :service do
  describe '#call' do
    let(:id) { content.id }

    subject { described_class.new(id).call }

    context 'when the content is a TvShow' do
      let(:content) { create(:tv_show, title: "The last of us") }
      let!(:season1) { create(:season, title: "season 1", parent_content: content) }
      let!(:season2) { create(:season, title: "season 2", parent_content: content) }
      let!(:episode1) { create(:episode, title: "episode 1", parent_content: season1) }
      let!(:episode2) { create(:episode, title: "episode 2", parent_content: season2) }

      it 'returns the TvShow with preloaded seasons and episodes' do
        result = subject

        expect(result).to eq(content)
        expect(result.seasons).to include(season1, season2)
        expect(result.seasons.first.episodes).to include(episode1)
        expect(result.seasons.last.episodes).to include(episode2)
      end
    end

    context 'when the content is a Channel' do
      let(:content) { create(:channel, title: "MTV") }
      let!(:program1) { create(:channel_program, title: "One", parent_content: content) }
      let!(:program2) { create(:channel_program, title: "Two", parent_content: content) }
      let!(:schedule1) { create(:content_schedule, content: program1) }
      let!(:schedule2) { create(:content_schedule, content: program2) }

      it 'returns the Channel with preloaded channel programs and content schedules' do
        result = subject

        expect(result).to eq(content)
        expect(result.channel_programs).to include(program1, program2)
        expect(result.channel_programs.first.content_schedules).to include(schedule1)
        expect(result.channel_programs.last.content_schedules).to include(schedule2)
      end
    end

    context 'when the content is another type' do
      let(:content) { create(:movie, title: "Interstelar") }

      it 'returns the content as is' do
        result = subject

        expect(result).to eq(content)
      end
    end

    context 'when the content does not exist' do
      let(:id) { 9999 }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
