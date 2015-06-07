require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, 'e92dd3df52654091af90b4737a973270', '8f4fa425a87542cca4848e48c00647e9', 
  scope: 'user-read-private user-read-email user-library-read playlist-modify-private playlist-read-private'

  # provider, api_id , app_secret, scope...
end
