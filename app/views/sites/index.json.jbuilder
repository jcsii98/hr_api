json.array! @sites do |site|
    json.id site.id
    json.name site.name
    json.status site.status
end