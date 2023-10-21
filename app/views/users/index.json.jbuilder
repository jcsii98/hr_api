json.array! @indexed_users do |indexed_user|
    json.id indexed_user.id
    json.email indexed_user.email
    json.full_name indexed_user.full_name
    json.kind indexed_user.kind
    json.status indexed_user.status
end