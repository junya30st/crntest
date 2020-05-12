json.extract! transaction, :id, :name, :price, :period, :customer_id, :product_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
