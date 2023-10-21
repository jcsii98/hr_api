class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.references :user, foreign_key: true
      t.references :site, foreign_key: true

      t.datetime :time_in
      t.datetime :time_out
      t.text :photo_in
      t.text :photo_out
      t.integer :shift_duration
      t.date :date
      t.text :status, default: "pending"
      
      t.timestamps
    end
  end
end
