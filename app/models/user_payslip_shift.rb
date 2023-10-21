class UserPayslipShift < ApplicationRecord
    belongs_to :user_payslip
    belongs_to :shift

end
