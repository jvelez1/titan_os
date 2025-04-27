class CreateContentSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :content_schedules do |t|
      t.belongs_to :content, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end
  end
end
