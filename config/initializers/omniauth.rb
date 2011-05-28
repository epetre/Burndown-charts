Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'MZFHv1uYQYyj8D0RoqDbpQ', 'zuHNgvdz8EjqX2mFbrA4FDHoFtbigHaB1gWcciRZgI'
  #provider :facebook, 'APP_ID', 'APP_SECRET'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
module ApplicationHelper
  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end
end
