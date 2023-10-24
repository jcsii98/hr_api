sorted_users = @users.sort_by { |user| user.last_name }

json.array! sorted_users do |user|
    json.id user.id
    json.email user.email
    json.first_name user.first_name
    json.middle_name user.middle_name
    json.last_name user.last_name
    json.kind user.kind
    json.status user.status
end