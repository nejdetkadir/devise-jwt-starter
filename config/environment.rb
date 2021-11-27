# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.smtp_settings = {
    address: ENV['SMTP_MAIL_ADDRESS'],
    port: ENV['SMTP_MAIL_PORT'].to_i,
    domain: ENV['SMTP_MAIL_DOMAIN'],
    user_name: ENV['SMTP_MAIL_USERNAME'],
    password: ENV['SMTP_MAIL_PASSWORD'],
    authentication: 'plain',
    ssl: true,
    tsl: true,
    enable_starttls_auto: true
  }
end
