class ContactsController < ApplicationController
  def index
    @contacts = Contact.all.order(created_at: :desc)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = 'We have received your message and will get back to you shortly.'
      redirect_to root_path
    else
      flash[:danger] = @contact.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:success] = 'Message updated successfully.'
      redirect_to @contact
    else
      flash[:danger] = @contact.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    flash[:success] = 'Message deleted successfully.'
    redirect_to contacts_path
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
