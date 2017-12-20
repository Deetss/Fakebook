class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@fakebook.com'
  layout 'mailer'
end

