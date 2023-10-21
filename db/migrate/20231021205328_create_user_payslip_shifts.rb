class CreateUserPayslipShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_payslip_shifts do |t|
      t.references :user_payslip, foreign_key: true
      t.references :shift, foreign_key: true
      
      t.timestamps
    end
  end
end
