class ContactsController < ApplicationController 
  # the new method will instantiate an empty Contact model, assign  it to the @contact instance variable, and render the new .html.erb view in views/contact/new.  The 'new' and 'create' methods are related. The new method will give us the ability to add new information, and the create method will save this information.  Remember than the new method renders on it's own. 
  def new 
    @contact = Contact.new 
  end 
  
  def create 
    @contact = Contact.new(secure_params) 
    if @contact.valid? 
      #valid is a methond from Activemodel, and checks inputs against requirements set outin model, 
      @contact.update_spreadsheet 
      UserMailer.contact_email(@contact).deliver
      # TODO send message 
      flash[:notice] = "Message sent from #{@contact.name}."
      redirect_to root_path
    else 
      render :new 
    end 
  end 
  
  private 
  
  def secure_params 
    params.require(:contact).permit(:name, :email, :content)
  end 

end
