json.array! @sitePayslips do |site_payslip|
    json.id site_payslip.id
    json.date site_payslip.date
    json.week_start site_payslip.week_start
    json.week_end site_payslip.week_end
    json.amount site_payslip.amount
    json.status site_payslip.status
end