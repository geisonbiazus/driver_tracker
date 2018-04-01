class AddDriverIdTimestampIndexToActivityEvent < ActiveRecord::Migration[5.1]
  def change
    add_index :activity_events, [:driver_id, :timestamp]
  end
end
