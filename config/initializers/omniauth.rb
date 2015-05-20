require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, 'e92dd3df52654091af90b4737a973270', 'db96fd52c8a046f8bad2962f855d75e7', scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
