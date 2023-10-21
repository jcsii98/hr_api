json.id @shift.id
json.user_id @shift.user_id
json.date @shift.date
json.time_in @shift.time_in

if @shift.shift_duration
    json.time_out @shift.time_out
    json.shift_duration @shift.shift_duration
end