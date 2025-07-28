Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"  # 開発中は *（全許可）、本番では React のURLを指定
    resource "/api/*",
      headers: :any,
      methods: [ :get, :post, :options ]
  end
end
