# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'donotrespond@mail.com'
  layout 'mailer'
end
