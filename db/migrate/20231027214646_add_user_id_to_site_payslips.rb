class AddUserIdToSitePayslips < ActiveRecord::Migration[7.0]
  def change
    add_reference :site_payslips, :user, null: false, foreign_key: true
  end
end
