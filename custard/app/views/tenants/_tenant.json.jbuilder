json.extract! tenant, :id, :name, :description, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)