# OmniAuth.config.logger = Rails.logger
# OmniAuth.config.logger = Logger.new(STDOUT)
# OmniAuth.logger.progname = "omniauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1006946089485811', 'f663e938d625a243f67d7412535e4c14',
    scope: 'email, public_profile',
    info_fields: 'email, first_name, last_name'
  # provider :line, '1511152097', '9d0d7f2b16a97f75f2f320a35bb37b2b'
end
