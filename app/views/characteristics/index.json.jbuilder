json.array!(@characteristics) do |characteristic|
  json.extract! characteristic, :id, :name, :inventory_type_id
  json.url characteristic_url(characteristic, format: :json)
end
