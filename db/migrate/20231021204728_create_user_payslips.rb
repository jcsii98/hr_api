class CreateUserPayslips < ActiveRecord::Migration[7.0]
  def change
    create_table :user_payslips do |t|
      t.references :user, foreign_key: true

      t.date :week_start
      t.date :week_end
      t.date :date

      t.integer :amount
      t.integer :cash_advance

      t.timestamps
    end
  end
end
