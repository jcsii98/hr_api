class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.text :name
      t.text :status, default: "hidden"

      t.timestamps
    end
  end
end
