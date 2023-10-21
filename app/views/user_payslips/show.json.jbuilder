json.extract! @userPayslip, :id, :date, :week_start, :week_end,  :total_duration, :amount, :cash_advance

json.shifts @userPayslip.shifts do |shift|
  json.id shift.id
  json.date shift.date
  json.shift_duration shift.shift_duration
  json.time_in shift.time_in
  json.time_out shift.time_out
  json.status shift.status
end