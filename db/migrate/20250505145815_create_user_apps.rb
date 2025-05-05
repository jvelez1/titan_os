class CreateUserApps < ActiveRecord::Migration[8.0]
  def change
    create_table :user_apps do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :streaming_app, null: false, foreign_key: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
