class CreateContentAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :content_availabilities do |t|
      t.string :url, null: true

      t.belongs_to :content, null: false, foreign_key: true
      t.belongs_to :streaming_app, null: false, foreign_key: true
      t.belongs_to :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
