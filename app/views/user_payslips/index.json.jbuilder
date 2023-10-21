json.array! @userPayslips do |user_payslip|
    json.id user_payslip.id
    json.date user_payslip.date
    json.week_start user_payslip.week_start
    json.week_end user_payslip.week_end
    json.total_duration user_payslip.total_duration
    json.amount user_payslip.amount
end