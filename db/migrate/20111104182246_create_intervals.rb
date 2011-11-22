class CreateIntervals < ActiveRecord::Migration
  def change
    create_table :intervals do |t|
      t.integer :workout_id
      t.string :interval_name

      t.timestamps
    end
  end
end
