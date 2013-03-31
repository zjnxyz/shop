# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shop::Application.initialize!
ActionMailer::Base.smtp_settings =
    {
        :address => "smtp.126.com",
        :domain => "mail.126.com",
        :user_name => "zjn100002@126.com",
        :password => "zjn621705",
        :authentication => :login
    }
