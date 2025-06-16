Rails.application.config.sorcery.submodules = [
  :remember_me,
  :user_activation
]

Rails.application.config.sorcery.configure do |config|

  config.user_config do |user|

    user.user_activation_mailer = UserMailer
    user.activation_token_attribute_name = :activation_token
    user.activation_state_attribute_name = :activation_state
    user.activation_token_expires_at_attribute_name = :activation_token_expires_at
    user.activation_token_expiration_period = 24.hours
    user.activation_needed_email_method_name = :activation_needed_email
    user.activation_success_email_method_name = :activation_success_email
  end

  config.user_class = "User"
end
