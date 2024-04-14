Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:4200', '127.0.0.1:4200'
    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options]
  end
end
