class AddNameToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :name, :text, limit: 100
  end
end
