class AddStatusToSitePayslip < ActiveRecord::Migration[7.0]
  def change
    add_column :site_payslips, :status, :text, default: "pending"
  end
end
