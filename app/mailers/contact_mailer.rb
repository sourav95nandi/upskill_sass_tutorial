class ContactMailer < ApplicationMailer
    default to: 'souravnandi@ymail.com'

    def contact_email(name, email, message)
        @name = name
        @email = email
        @message = message

        mail(from: email, subject: 'New Contact Form Message')
    end
end