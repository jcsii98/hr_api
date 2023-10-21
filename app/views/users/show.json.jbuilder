json.id @user.id
json.email @user.email
json.full_name @user.full_name
json.kind @user.kind
json.profile_picture @user.profile_picture

if @user.kind == "user"
    json.birthday @user.birthday
    json.personal_rate @user.personal_rate
    json.status @user.status
end