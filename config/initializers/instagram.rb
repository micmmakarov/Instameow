require "instagram"

Instagram.configure do |config|
	  config.client_id =    ENV['insta_client_id']
	  config.client_secret = ENV['insta_client_secret']
end


if Rails.env.development?
	CALLBACK_URL = "http://localhost:3000/session/callback"
end
if  Rails.env.production?
	CALLBACK_URL = "http://instameow.herokuapp.com/session/callback"
end