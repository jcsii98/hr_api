class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :user, foreign_key: true
      t.references :site, foreign_key: true

      t.integer :amount
      t.text :scope
      t.date :date
      t.text :status, default: 'pending'

      t.timestamps
    end
  end
end
