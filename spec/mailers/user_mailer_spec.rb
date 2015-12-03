require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'confirmation email' do
     it 'should have the correct url and have the users name' do
        user = User.new(name: "Tom", confirmation_code: "123abc", email: "test@gmail.com")
        mail = UserMailer.email_confirmation(user)
        expect(mail.html_part.body).to include("http://agile-plateau-1043.herokuapp.com/users/#{user.id}/confirm/#{user.confirmation_code}")
     end
  end
end
