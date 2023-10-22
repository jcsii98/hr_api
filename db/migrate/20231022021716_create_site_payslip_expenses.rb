class CreateSitePayslipExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :site_payslip_expenses do |t|
      t.references :site_payslip, foreign_key: true
      t.references :expense, foreign_key: true
      
      t.timestamps
    end
  end
end
