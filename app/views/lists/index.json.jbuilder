json.array!(@lists) do |list|
  json.extract! list, :id, :subject, :public_access
  json.url list_url(list, format: :json)
end
