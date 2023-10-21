json.id @user.id
json.email @user.email
json.full_name @user.full_name

if @user.kind == "user"
    json.birthday @user.birthday
    json.personal_rate @user.personal_rate
    json.status @user.status
end

json.kind @user.kind