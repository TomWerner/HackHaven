class UserMailer < ApplicationMailer
    default from: 'uiowahackhaven@gmail.com'
 
    def email_confirmation(user)
        @user = user
        @url  = "http://agile-plateau-1043.herokuapp.com/users/#{user.id}/confirm/#{user.confirmation_code}"
        mail(to: @user.email, subject: 'Confirm your account on HackHaven!')
    end
end
