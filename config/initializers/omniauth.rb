# OmniAuth.config.logger = Rails.logger
# OmniAuth.config.logger = Logger.new(STDOUT)
# OmniAuth.logger.progname = "omniauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_KEY'], ENV['FB_SEC'],
    scope: 'email, public_profile',
    info_fields: 'email, first_name, last_name'
  # provider :line, ENV['LINE_KEY'], ENV['LINE_SEC']
  provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SEC']
end
