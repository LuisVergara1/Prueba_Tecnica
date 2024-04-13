Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost', '127.0.0.1'
    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options]
  end
end
