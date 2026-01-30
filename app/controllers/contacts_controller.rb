class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to new_contact_path, notice: 'Your message has been sent successfully.'
    else
      redirect_to new_contact_path, alert: 'There was an error sending your message. Please try again.'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
