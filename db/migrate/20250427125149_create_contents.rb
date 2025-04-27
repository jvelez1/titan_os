class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.string :type, null: false
      t.string :title, index: true
      t.integer :year, index: true
      t.integer :duration_in_seconds
      t.integer :number
      t.references :parent_content, foreign_key: { to_table: :contents }

      t.timestamps
    end
  end
end
