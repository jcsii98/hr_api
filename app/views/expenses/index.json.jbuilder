json.array! @expenses do |expense|
    json.id expense.id
    json.site_id expense.site_id
    json.user_id expense.user_id
    json.name expense.name
    json.date expense.date
    json.amount expense.amount
    json.scope expense.scope

    json.status expense.status
end