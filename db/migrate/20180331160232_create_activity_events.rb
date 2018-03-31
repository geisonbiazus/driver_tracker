class CreateActivityEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_events do |t|
      t.references :company, foreign_key: true
      t.integer :driver_id
      t.timestamp :timestamp
      t.float :latitude
      t.float :longitude
      t.float :accuracy
      t.float :speed
      t.string :activity

      t.timestamps
    end
  end
end
