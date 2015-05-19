class UserMailer < ActionMailer::Base
  def reset_password_email(user)
    @user = user
    @url  = "http://#{mailer_hostname}/password_resets/#{user.reset_password_token}/edit"
    mail(from: "noreply@#{mailer_hostname}", to: user.email, subject: "Your Beerventory password has been reset")
  end

  private

  def mailer_hostname
    if Rails.env.production?
      "guarded-ravine-1984.herokuapp.com"
    else
      "localhost:3000"
    end
  end
end
