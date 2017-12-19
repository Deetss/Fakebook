Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['fb_api_key'], ENV['fb_api_secret']
end