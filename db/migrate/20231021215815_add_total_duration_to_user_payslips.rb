class AddTotalDurationToUserPayslips < ActiveRecord::Migration[7.0]
  def change
    add_column :user_payslips, :total_duration, :integer
  end
end
