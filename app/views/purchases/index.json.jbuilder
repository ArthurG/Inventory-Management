json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :name, :category, :cad_price, :usd_price, :quantity
  json.url purchase_url(purchase, format: :json)
end
