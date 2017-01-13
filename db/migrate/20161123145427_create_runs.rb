class CreateRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.string   :distance
      t.string    :run_time
      t.string    :run_pace
      t.references :runner, null: false
      t.references :companion
      t.string   :run_date, null: false
      t.integer     :time, null: false
      t.string    :zipcode
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps(null: false)
    end
  end
end
