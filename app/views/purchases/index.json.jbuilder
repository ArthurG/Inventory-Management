json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :name, :quantity, :category, :cadprice, :usdprice, :added
  json.url purchase_url(purchase, format: :json)
end
