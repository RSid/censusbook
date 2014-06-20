Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    :scope => 'public_profile,email,user_hometown,user_location,user_tagged_places', :display => 'popup'
end
