module Events::EmailUser

  # send event emails
  def email_users!
    email_recipients.without(user).each { |recipient| email_user!(recipient) }
  end
  handle_asynchronously :email_users!

  private

  def email_user!(recipient)
    mailer.send(kind, recipient, self).deliver_now
  end

  # which users should receive an email about this event?
  def email_recipients
    User.none
  end

  # which mailer should be used to send emails about this event?
  def mailer
    ThreadMailer
  end
end
