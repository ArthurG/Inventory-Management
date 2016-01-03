json.array!(@purchase_categories) do |purchase_category|
  json.extract! purchase_category, :id, :name
  json.url purchase_category_url(purchase_category, format: :json)
end
