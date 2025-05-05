require 'rails_helper'

RSpec.describe Favorites::SetFavoriteApp, type: :service do
  let(:user) { create(:user) }
  let(:streaming_app1) { create(:streaming_app, name: 'App1') }
  let(:streaming_app2) { create(:streaming_app, name: 'App2') }
  let(:streaming_app3) { create(:streaming_app, name: 'App3') }

  before do
    create(:user_app, user: user, streaming_app: streaming_app1, position: 1)
    create(:user_app, user: user, streaming_app: streaming_app2, position: 2)
    create(:user_app, user: user, streaming_app: streaming_app3, position: 3)
  end

  describe '#call' do
    context 'when setting a new favorite app' do
      it 'sets the app as favorite and adjusts positions' do
        service = Favorites::SetFavoriteApp.new(user, { streaming_app_id: streaming_app3.id, position: 1 })
        service.call
        user_apps = user.user_apps.order(:position)

        expect(user_apps.map(&:streaming_app_id)).to eq([ streaming_app3.id, streaming_app1.id, streaming_app2.id ])
        expect(user_apps.map(&:position)).to eq([ 1, 2, 3 ])
      end
    end

    context 'when updating the position of an existing favorite app' do
      it 'updates the position and adjusts other apps accordingly' do
        service = Favorites::SetFavoriteApp.new(user, { streaming_app_id: streaming_app1.id, position: 3 })
        service.call
        user_apps = user.user_apps.order(:position)

        expect(user_apps.map(&:streaming_app_id)).to eq([ streaming_app2.id, streaming_app3.id, streaming_app1.id ])
        expect(user_apps.map(&:position)).to eq([ 1, 2, 3 ])
      end
    end

    context 'when the app is already in the desired position' do
      it 'does not make any changes' do
        service = Favorites::SetFavoriteApp.new(user, { streaming_app_id: streaming_app1.id, position: 1 })

        expect { service.call }.not_to change { user.user_apps.pluck(:position) }
      end
    end

    context 'when the app does not exist for the user' do
      let(:new_streaming_app) { create(:streaming_app) }

      it 'initializes the app and sets it as favorite' do
        service = Favorites::SetFavoriteApp.new(user, { streaming_app_id: new_streaming_app.id, position: 2 })
        service.call

        user_apps = user.user_apps.order(:position)

        expect(user_apps.map(&:streaming_app_id)).to eq([ streaming_app1.id, new_streaming_app.id, streaming_app2.id, streaming_app3.id ])
        expect(user_apps.map(&:position)).to eq([ 1, 2, 3, 4 ])
      end
    end

    context 'when an invalid position is provided' do
      it 'raises an error and does not change the positions' do
        service = Favorites::SetFavoriteApp.new(user, { streaming_app_id: streaming_app1.id, position: 0 })

        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
        expect(user.user_apps.pluck(:position)).to eq([ 1, 2, 3 ])
      end
    end

    context 'when the app does not exist in the database' do
      it 'raises an error if the app is not found' do
        non_existent_app_id = 9999

        service = Favorites::SetFavoriteApp.new(user, { streaming_app_id: non_existent_app_id, position: 2 })

        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
        expect(user.user_apps.pluck(:position)).to eq([ 1, 2, 3 ])
      end
    end
  end
end
