class SitePayslipExpense < ApplicationRecord
    belongs_to :site_payslip
    belongs_to :expense
    
end
