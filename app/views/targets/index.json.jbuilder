json.array!(@targets) do |target|
  json.extract! target, :host, :path
  json.url target_url(target, format: :json)
end