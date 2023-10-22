json.extract! @sitePayslip, :id, :date, :week_start, :week_end, :amount

json.expenses @sitePayslip.expenses do |expense|
  json.id expense.id
  json.user_id expense.user_id
  json.site_id expense.site_id
  json.scope expense.scope
  json.name expense.name
  json.amount expense.amount
  json.date expense.date
  
  json.status expense.status
end