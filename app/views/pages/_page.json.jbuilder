json.extract! page, :id, :title, :layout, :order, :dental, :medical, :vision, :created_at, :updated_at
json.url page_url(page, format: :json)
