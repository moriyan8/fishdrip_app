Rails.application.config.sorcery.submodules = [
  :remember_me,
  :external
  # :user_activation
]

Rails.application.config.sorcery.configure do |config|
  config.user_config do |user|
    # user.user_activation_mailer = UserMailer
    # user.activation_token_attribute_name = :activation_token
    # user.activation_state_attribute_name = :activation_state
    # user.activation_token_expires_at_attribute_name = :activation_token_expires_at
    # user.activation_token_expiration_period = 24.hours
    # user.activation_needed_email_method_name = :activation_needed_email
    # user.activation_success_email_method_name = :activation_success_email
  end

  config.external_providers = [ :google ]

  config.google.key = ENV["GOOGLE_CLIENT_ID"]
  config.google.secret = ENV["GOOGLE_CLIENT_SECRET"]
  config.google.callback_url = if Rails.env.production?
    "https://fishdrip.jp/oauth/callback?provider=google"
  else
    "http://localhost:3000/oauth/callback?provider=google"
  end
  config.google.scope = "email profile"

  config.user_class = "User"
end
