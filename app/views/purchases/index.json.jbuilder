json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :name, :cad_price, :usd_price, :purchase_category_id
  json.url purchase_url(purchase, format: :json)
end
