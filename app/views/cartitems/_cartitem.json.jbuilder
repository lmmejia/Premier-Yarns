json.extract! cartitem, :id, :cart_id, :product_id, :created_at, :updated_at
json.url cartitem_url(cartitem, format: :json)
