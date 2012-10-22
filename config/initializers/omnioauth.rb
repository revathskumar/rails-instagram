Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :instagram, CONFIG['instagram_credentials']['client_id'], CONFIG['instagram_credentials']['client_secret']
end unless Rails.env.test?
