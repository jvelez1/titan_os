class CreateUserChannelPrograms < ActiveRecord::Migration[8.0]
  def change
    create_table :user_channel_programs do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :channel_program, null: false, foreign_key: { to_table: :contents }
      t.bigint :time_watched_in_seconds, null: false, default: 0

      t.timestamps
    end

    add_index :user_channel_programs, [ :user_id, :channel_program_id ], unique: true
  end
end
