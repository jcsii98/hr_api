# Sort the @sites array by name
sorted_sites = @sites.sort_by { |site| site.name }

# Build the JSON array using jbuilder
json.array! sorted_sites do |site|
  json.id site.id
  json.name site.name
  json.status site.status
end
