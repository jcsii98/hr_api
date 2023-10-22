class CreateSitePayslips < ActiveRecord::Migration[7.0]
  def change
    create_table :site_payslips do |t|
      t.references :site, foreign_key: true

      t.date :week_start
      t.date :week_end
      t.date :date

      t.integer :amount
      
      t.timestamps
    end
  end
end
