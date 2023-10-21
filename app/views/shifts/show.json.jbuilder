json.id @shift.id
json.user_id @shift.user_id
json.date @shift.date
json.time_in @shift.time_in
json.photo_in @shift.photo_in

if @shift.shift_duration
    json.time_out @shift.time_out
    json.photo_out @shift.photo_out
    json.shift_duration @shift.shift_duration
end